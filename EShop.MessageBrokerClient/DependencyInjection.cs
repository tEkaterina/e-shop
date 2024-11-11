using EShop.MessageBrokerClient.Configuration;
using EShop.MessageBrokerClient.RabbitMq;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace EShop.MessageBrokerClient;

public static class DependencyInjection
{
    public static IServiceCollection AddMessageBroker(this IServiceCollection services, IConfiguration config)
    {
        services.Configure<MessageBrokerConfig>(config.GetSection("MessageBrokerConfig"));

        services.AddTransient<IMessageListener, MessageListener>();
        services.AddTransient<IMessagePublisher, MessagePublisher>();
        services.AddSingleton<IMessageBrokerContext, MessageBrokerContext>();
        services.AddSingleton<IMessageBroker, MessageBroker>();

        return services;
    }
}
