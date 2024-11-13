namespace CartService.Services.Events.ProductChanged;

internal interface IProductChangePublisher : IDisposable
{
    event EventHandler<ProductChangeEvent> OnProductChanged;
}
