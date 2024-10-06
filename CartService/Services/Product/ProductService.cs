using CartService.Services.Catalog;
using CartService.Services.Dto;

namespace CartService.Services.Product
{
    public class ProductService(ICatalogService catalogService) : IProductService
    {
        private readonly ICatalogService _catalogService = catalogService;

        public async Task<ProductDto?> GetProductAsync(int productId)
        {
            CatalogProduct? product = await _catalogService.GetAsync(productId);
            if (product == null)
            {
                return null;
            }

            return new ProductDto(productId, product.Name)
            {
                Description = product.Description,
                ImageUrl = product.ImageUrl,
                Price = product.Price,
            };
        }
    }
}
