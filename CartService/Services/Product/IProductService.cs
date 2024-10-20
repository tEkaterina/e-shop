using CartService.Services.Common.Dto;

namespace CartService.Services.Product
{
    public interface IProductService
    {
        Task<ProductDto?> GetProductAsync(int productId);
    }
}
