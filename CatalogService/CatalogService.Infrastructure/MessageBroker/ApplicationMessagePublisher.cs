using CatalogService.Application.Common.Interfaces;
using CatalogService.Domain.Events;
using EShop.MessageBrokerClient;

namespace CatalogService.Infrastructure.MessageBroker;

public class ApplicationMessagePublisher(IMessageBroker broker) : IApplicationMessagePublisher
{
    public async Task PublishProductUpdateAsync(ProductChangeEvent message)
    {
        await broker.PublishAsync(MessageBrokerConst.ProductSyncQueue, message);
    }
}
