namespace EShop.MessageBrokerClient;

public interface IMessagePublisher
{
    public ValueTask PublishAsync<T>(string queue, T message);
}
