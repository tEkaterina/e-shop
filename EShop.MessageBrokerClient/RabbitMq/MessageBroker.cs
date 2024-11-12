namespace EShop.MessageBrokerClient.RabbitMq;

internal class MessageBroker(IMessageBrokerContext context, IMessageListener listener, IMessagePublisher publisher) : IMessageBroker
{
    private bool _disposed = false;

    public Task InitializeAsync(CancellationToken token = default)
    {
        return context.InitializeAsync(token);
    }

    public Task SubscribeAsync(string queue, Action<string> messageHandler)
    {
        return listener.SubscribeAsync(queue, messageHandler);
    }

    public void Unsubscribe(string queue, Action<string> messageHandler)
    {
        listener.Unsubscribe(queue, messageHandler);
    }

    public ValueTask PublishAsync<T>(string queue, T messageObject)
    {
        return publisher.PublishAsync(queue, messageObject);
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
            context.Dispose();
        }

        _disposed = true;
    }

    protected async virtual ValueTask DisposeAsyncCore()
    {
        if (_disposed)
        {
            return;
        }

        await context.DisposeAsync();
    }


    ~MessageBroker() => Dispose(disposing: false);
}
