using CartService.DataAccess.Common.Entities;
using CartService.DataAccess.Repository.Product;
using CartService.Services.Events.ProductChanged;

namespace CartService.Services.Product;

internal class ProductChangeListener(IProductChangePublisher changePublisher, IProductRepository repository) : IProductChangeListener
{
    public Task StartAsync(CancellationToken cancellationToken)
    {
        changePublisher.OnProductChanged += HandleProductChangeAsync;
        return Task.CompletedTask;
    }

    public Task StopAsync(CancellationToken cancellationToken)
    {
        changePublisher.OnProductChanged -= HandleProductChangeAsync;
        return Task.CompletedTask;
    }

    private void HandleProductChangeAsync(object? source, ProductChangeEventPayload eventPayload)
    {
        int existingProductId = eventPayload.ProductId;
        ProductEntity? existingProduct = repository.GetProduct(existingProductId);

        if (existingProduct != null)
        {
            var updatedProduct = existingProduct with
            {
                Description = eventPayload.Details.Description,
                Image = eventPayload.Details.Image,
                Name = eventPayload.Details.Name,
                Price = eventPayload.Details.Price,
            };

            repository.SaveProduct(updatedProduct);
        }
    }
}
