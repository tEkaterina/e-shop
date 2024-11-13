using CatalogService.Domain.Events;

namespace CatalogService.Application.Common.Interfaces;

public interface IApplicationMessagePublisher
{
    Task PublishProductUpdateAsync(ProductChangeEvent message);
}
