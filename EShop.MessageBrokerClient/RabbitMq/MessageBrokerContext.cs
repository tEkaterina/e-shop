using EShop.MessageBrokerClient.Configuration;
using EShop.MessageBrokerClient.Exceptions;
using Microsoft.Extensions.Options;
using System.Threading.Channels;

namespace EShop.MessageBrokerClient.RabbitMq;

internal class MessageBrokerContext(IOptions<MessageBrokerConfig> config) : IMessageBrokerContext
{
    private bool _disposed = false;
    private bool _initialized = false;

    private IConnection? _connection;
    private IChannel? _channel;

    public IChannel Channel
    {
        get
        {
            if (!_initialized)
            {
                throw new UninitializedMessageBrokerException();
            }

            return _channel;
        }
    }

    public async Task InitializeAsync(CancellationToken token = default)
    {
        if (_initialized)
        {
            return;
        }

        var factory = new ConnectionFactory
        {
            UserName = config.Value.UserName,
            HostName = config.Value.HostName,
            Password = config.Value.Password,
            VirtualHost = config.Value.VirtualHost,
        };

        if (config.Value.Port.HasValue){
            factory.Port = config.Value.Port.Value;
        }

        _connection = await factory.CreateConnectionAsync(token);
        _channel = await _connection.CreateChannelAsync();

        _initialized = true;
    }

    public async Task CreateQueueAsync(string queueName)
    {
        await Channel.QueueDeclareAsync(
            queueName,
            config.Value.CommonQueueSetup.Durable,
            config.Value.CommonQueueSetup.Exclusive,
            config.Value.CommonQueueSetup.AutoDelete
        );
    }

    public void Dispose()
    {
        Dispose(disposing: true);
        GC.SuppressFinalize(this);
    }

    public async ValueTask DisposeAsync()
    {
        await DisposeAsyncCore().ConfigureAwait(false);

        Dispose(disposing: false);
        GC.SuppressFinalize(this);
    }

    protected virtual void Dispose(bool disposing)
    {
        if (_disposed)
        {
            return;
        }

        if (disposing)
        {
            if (_channel is IDisposable)
            {
                _channel.Dispose();
                _channel = null;
            }

            if (_connection is IDisposable)
            {
                _connection.Dispose();
                _connection = null;
            }
        }

        _disposed = true;
    }

    protected async virtual ValueTask DisposeAsyncCore()
    {
        if (_channel is not null)
        {
            await _channel.CloseAsync();
            await _channel.DisposeAsync().ConfigureAwait(false);
            _channel = null;
        }

        if (_connection is not null)
        {
            await _connection.CloseAsync();
            await _connection.DisposeAsync().ConfigureAwait(false);
            _connection = null;
        }
    }

    ~MessageBrokerContext() => Dispose(disposing: false);
}
