namespace EShop.MessageBrokerClient.Configuration;

public record CommonQueueSetup
{
    public bool Durable { get; init; } = true;
    public bool Exclusive { get; init; } = false;
    public bool AutoDelete { get; init; } = false;
}
