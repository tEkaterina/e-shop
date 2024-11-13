namespace EShop.MessageBrokerClient;

public interface IMessagePublisher
{
    Task PublishAsync<T>(string queue, T message);
}
