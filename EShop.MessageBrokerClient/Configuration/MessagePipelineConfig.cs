namespace EShop.MessageBrokerClient.Configuration;

public record MessagePipelineConfig(string Name, string Queue, string Exchange, string Route);
