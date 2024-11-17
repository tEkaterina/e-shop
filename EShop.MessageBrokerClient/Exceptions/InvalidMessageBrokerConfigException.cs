namespace EShop.MessageBrokerClient.Exceptions;

public class InvalidMessageBrokerConfigException(string reason): Exception($"Invalid configuration provided to message broker: {reason}");
