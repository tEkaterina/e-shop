using System.Text.Json;
using System.Text;

namespace EShop.MessageBrokerClient.RabbitMq;

internal class MessagePublisher(IMessageBrokerContext context) : IMessagePublisher
{
    public async ValueTask PublishAsync<T>(string queue, T messageObject)
    {
        await context.CreateQueueAsync(queue);

        var message = JsonSerializer.Serialize(messageObject);
        var messagePackage = Encoding.UTF8.GetBytes(message);

        BasicProperties properties = new() {
            DeliveryMode = DeliveryModes.Persistent,
        };

        await context.Channel.BasicPublishAsync(string.Empty, string.Empty, mandatory: true, properties, messagePackage);
    }
}
