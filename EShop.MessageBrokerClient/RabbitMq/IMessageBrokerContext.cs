namespace EShop.MessageBrokerClient.RabbitMq;

internal interface IMessageBrokerContext : IDisposable, IAsyncDisposable
{
    IChannel Channel { get; }

    Task InitializeAsync(CancellationToken token = default);

    Task CreateQueueAsync(string queue);
}
