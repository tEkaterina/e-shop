namespace EShop.MessageBrokerClient;

public interface IMessageListener
{
    Task SubscribeAsync(string queue, Func<byte[], Task> messageHandler);

    void Unsubscribe(string queue, Func<byte[], Task> messageHandler);
}
