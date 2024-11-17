using RabbitMQ.Client.Events;
using System.Text;

namespace EShop.MessageBrokerClient.RabbitMq;

record MessageListenerContext(AsyncEventingBasicConsumer Consumer, AsyncEventHandler<BasicDeliverEventArgs> DeliveryHandler, IList<Action<string>> Handlers);

internal class MessageListener(IMessageBrokerContext context) : IMessageListener
{
    private readonly Dictionary<string, MessageListenerContext> _queueHandlers = [];

    public async Task SubscribeAsync(string queue, Action<string> messageHandler)
    {
        MessageListenerContext listenerContext = await GetOrCreateMessageContext(queue);
        listenerContext.Handlers.Add(messageHandler);
    }

    public void Unsubscribe(string queue, Action<string> messageHandler)
    {
        MessageListenerContext? listenerContext = GetMessageContext(queue);
        listenerContext?.Handlers.Remove(messageHandler);
    }

    private MessageListenerContext? GetMessageContext(string queue)
    {
        MessageListenerContext? messageContext;

        if (_queueHandlers.TryGetValue(queue, out messageContext))
        {
            return messageContext;
        }

        return messageContext;
    }

    private async Task<MessageListenerContext> GetOrCreateMessageContext(string queue)
    {
        MessageListenerContext? messageContext = GetMessageContext(queue);
        if (messageContext != null)
        {
            return messageContext;
        }


        if (_queueHandlers.TryGetValue(queue, out messageContext))
        {
            return messageContext;
        }

        var consumer = new AsyncEventingBasicConsumer(context.Channel);
        var handlers = new List<Action<string>>();

        AsyncEventHandler<BasicDeliverEventArgs> handler = async (_, package) =>
        {
            try
            {
                string message = Encoding.UTF8.GetString(package.Body.ToArray());

                foreach (var handler in handlers)
                {
                    handler(message);
                }

                await context.Channel.BasicAckAsync(package.DeliveryTag, multiple: false);
            }
            catch (Exception)
            {
                await context.Channel.BasicNackAsync(package.DeliveryTag, multiple: false, requeue: false);
                throw;
            }
        };

        messageContext = new(consumer, handler, handlers);

        consumer.ReceivedAsync += handler;

        _queueHandlers.Add(queue, messageContext);

        await context.SubscribeAsync(queue, consumer);

        return messageContext;
    }
}
