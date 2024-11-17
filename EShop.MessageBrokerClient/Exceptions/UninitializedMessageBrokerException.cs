namespace EShop.MessageBrokerClient.Exceptions;

public class UninitializedMessageBrokerException()
    : Exception("Message broker has not been initilized before accessing resources.")
{
}
