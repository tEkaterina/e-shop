namespace EShop.MessageBrokerClient;

public interface IMessageBroker : IMessageListener, IMessagePublisher, IDisposable, IAsyncDisposable
{
    public Task InitializeAsync(CancellationToken token = default);
}
