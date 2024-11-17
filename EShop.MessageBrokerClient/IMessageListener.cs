namespace EShop.MessageBrokerClient;

public interface IMessageListener
{
    Task SubscribeAsync(string queue, Action<string> messageHandler);

    void Unsubscribe(string queue, Action<string> messageHandler);
}
