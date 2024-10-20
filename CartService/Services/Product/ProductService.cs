using CartService.Services.Catalog;
using CartService.Services.Common.Dto;

namespace CartService.Services.Product;

public class ProductService(ICatalogService catalogService) : IProductService
{
    private readonly ICatalogService _catalogService = catalogService;

    public async Task<ProductDto?> GetProductAsync(int productId)
    {
        CatalogProduct? product = await _catalogService.GetAsync(productId);

        Guard.Against.NotFound(productId, product);

        return new ProductDto(productId, product.Name)
        {
            Description = product.Description,
            Image = product.ImageUrl,
            Price = product.Price,
        };
    }
}
