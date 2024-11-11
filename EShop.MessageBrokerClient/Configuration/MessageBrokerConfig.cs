namespace EShop.MessageBrokerClient.Configuration;

public record MessageBrokerConfig
{
    public required string UserName { get; init; }
    public required string Password { get; init; }
    public required string HostName { get; init; }
    public required string VirtualHost { get; init; }
    public int? Port { get; init; }

    public required CommonQueueSetup CommonQueueSetup { get; init; }
}
