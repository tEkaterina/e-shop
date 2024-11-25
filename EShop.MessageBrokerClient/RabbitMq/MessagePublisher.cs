using System.Text;
using System.Text.Json;

using EShop.MessageBrokerClient.Configuration;

namespace EShop.MessageBrokerClient.RabbitMq;

internal class MessagePublisher(IMessageBrokerContext context) : IMessagePublisher
{
    public async Task PublishAsync<T>(string queue, T messageObject)
    {
        var message = JsonSerializer.Serialize(messageObject);
        var messagePackage = Encoding.UTF8.GetBytes(message);

        await context.PublishAsync(queue, messagePackage).ConfigureAwait(false);
    }
}
