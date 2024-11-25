using EShop.MessageBrokerClient.Configuration;
using EShop.MessageBrokerClient.Exceptions;

using Microsoft.Extensions.Options;

namespace EShop.MessageBrokerClient.RabbitMq;

internal class MessageBrokerContext(IOptions<MessageBrokerConfig> config) : IMessageBrokerContext
{
    private bool _disposed = false;
    private bool _initialized = false;

    private IConnection? _connection;
    private IChannel? _channel;

    public IChannel GetChannel()
    {
        return !_initialized ? throw new UninitializedMessageBrokerException() : _channel!;
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

        if (config.Value.Port.HasValue)
        {
            factory.Port = config.Value.Port.Value;
        }

        _connection = await factory.CreateConnectionAsync(token).ConfigureAwait(false);
        _channel = await _connection.CreateChannelAsync(cancellationToken: token).ConfigureAwait(false);

        _initialized = true;
    }

    public async Task CreateQueueAsync(string pipelineName)
    {
        var pipelineConfig = GetPipelineConfig(pipelineName);

        Dictionary<string, object?> args = new()
        {
            {"x-message-ttl", 30000},
        };

        await GetChannel().QueueDeclareAsync(
            pipelineConfig.Queue,
            config.Value.CommonQueueSetup.Durable,
            config.Value.CommonQueueSetup.Exclusive,
            config.Value.CommonQueueSetup.AutoDelete,
            args
        ).ConfigureAwait(false);

        await GetChannel().ExchangeDeclareAsync(pipelineConfig.Exchange, ExchangeType.Direct, true, false).ConfigureAwait(false);

        await GetChannel().QueueBindAsync(pipelineConfig.Queue, pipelineConfig.Exchange, pipelineConfig.Route).ConfigureAwait(false);
    }

    public async Task PublishAsync(string pipelineName, byte[] message)
    {
        await CreateQueueAsync(pipelineName).ConfigureAwait(false);

        var pipelineConfig = GetPipelineConfig(pipelineName);
        BasicProperties properties = new()
        {
            DeliveryMode = DeliveryModes.Persistent,
        };

        await GetChannel().BasicPublishAsync(pipelineConfig.Exchange, pipelineConfig.Route, mandatory: true, properties, message).ConfigureAwait(false);
    }

    public async Task SubscribeAsync(string pipelineName, IAsyncBasicConsumer consumer)
    {
        await CreateQueueAsync(pipelineName).ConfigureAwait(false);
        var pipelineConfig = GetPipelineConfig(pipelineName);

        await GetChannel().BasicConsumeAsync(pipelineConfig.Queue, autoAck: false, consumer).ConfigureAwait(false);
    }

    public MessagePipelineConfig GetPipelineConfig(string pipelineName)
    {
        return config.Value.Pipelines.FirstOrDefault(x => x.Name == pipelineName)
            ?? throw new InvalidMessageBrokerConfigException($"unable to find {pipelineName} configuration.");
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
            await _channel.CloseAsync().ConfigureAwait(false);
            await _channel.DisposeAsync().ConfigureAwait(false);
            _channel = null;
        }

        if (_connection is not null)
        {
            await _connection.CloseAsync().ConfigureAwait(false);
            await _connection.DisposeAsync().ConfigureAwait(false);
            _connection = null;
        }
    }

    ~MessageBrokerContext() => Dispose(disposing: false);
}
