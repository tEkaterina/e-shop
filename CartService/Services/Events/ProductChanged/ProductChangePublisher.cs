using EShop.MessageBrokerClient;
using System.Text.Json;

namespace CartService.Services.Events.ProductChanged;

internal class ProductChangePublisher(IMessageBroker messageBroker) : IProductChangePublisher
{
    private EventHandler<ProductChangeEventPayload>? _handler;
    private bool _subscribed = false;
    private object _lock = new object();
    private bool _disposed = false;

    public event EventHandler<ProductChangeEventPayload> OnProductChanged
    {
        add
        {
            lock(_lock) {
                SubscribeOnQueue();
                _handler += value;
            }
        }
        remove
        {
            lock (_lock)
            {
                _handler -= value;
            }
        }
    }

    public void Dispose()
    {
        if (_disposed) return;
        
        Dispose(disposing: true);
        GC.SuppressFinalize(this);

        _disposed = true;
    }

    private Task SubscribeOnQueue()
    {
        if (_subscribed)
        {
            return Task.CompletedTask;
        }

        return messageBroker.SubscribeAsync(ProductChangeConst.QueueName, HandleProductPublish);
    }

    private void HandleProductPublish(string message)
    {
        var payload = JsonSerializer.Deserialize<ProductChangeEventPayload>(message)
            ?? throw new ProductChangeException("failed to get payload from the received message");

        _handler?.Invoke(this, payload);
    }

    private void Dispose(bool disposing)
    {
        if (disposing)
        {
            if (_subscribed) {
                messageBroker.Unsubscribe(ProductChangeConst.QueueName, HandleProductPublish);
            }

            _handler = null;
        }
    }

    ~ProductChangePublisher() => Dispose(disposing: false);
}
