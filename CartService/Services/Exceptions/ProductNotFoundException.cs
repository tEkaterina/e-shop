namespace CartService.Services.Exceptions
{
    public class ProductNotFoundException(int productId): Exception($"Catalog product with given id {productId} cannot be found.")
    {
    }
}
