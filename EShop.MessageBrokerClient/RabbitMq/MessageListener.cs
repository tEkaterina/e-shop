using RabbitMQ.Client.Events;

namespace EShop.MessageBrokerClient.RabbitMq;

record MessageListenerContext(AsyncEventingBasicConsumer Consumer, AsyncEventHandler<BasicDeliverEventArgs> DeliveryHandler, IList<Func<byte[], Task>> Handlers);

internal class MessageListener(IMessageBrokerContext context) : IMessageListener
{
    private readonly Dictionary<string, MessageListenerContext> _queueHandlers = [];
    private readonly ReaderWriterLockSlim _lock = new();

    public async Task SubscribeAsync(string queue, Func<byte[], Task> messageHandler)
    {
        MessageListenerContext listenerContext = await GetOrCreateMessageContext(queue);
        listenerContext.Handlers.Add(messageHandler);
    }

    public void Unsubscribe(string queue, Func<byte[], Task> messageHandler)
    {
        MessageListenerContext? listenerContext = GetMessageContext(queue);
        listenerContext?.Handlers.Remove(messageHandler);
    }

    private MessageListenerContext? GetMessageContext(string queue)
    {
        MessageListenerContext? messageContext;

        _lock.EnterReadLock();
        try
        {
            if (_queueHandlers.TryGetValue(queue, out messageContext))
            {
                return messageContext;
            }
        }
        finally
        {
            _lock.ExitReadLock();
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

        _lock.EnterWriteLock();

        try
        {
            if (_queueHandlers.TryGetValue(queue, out messageContext))
            {
                return messageContext;
            }

            await context.CreateQueueAsync(queue);

            var consumer = new AsyncEventingBasicConsumer(context.Channel);
            var handlers = new List<Func<byte[], Task>>();

            AsyncEventHandler<BasicDeliverEventArgs> handler = async (_, package) =>
            {
                try
                {
                    byte[] message = package.Body.ToArray();

                    await Task.WhenAll(handlers.Select(x => x(message)));

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

            await context.Channel.BasicConsumeAsync(queue, autoAck: false, consumer);

            return messageContext;
        }
        finally
        {
            _lock.ExitWriteLock();
        }
    }
}
