using CartService.Services.Dto;

namespace CartService.Services.Product
{
    public interface IProductService
    {
        Task<ProductDto?> GetProductAsync(int productId);
    }
}
