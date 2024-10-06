using CartService.Services.Dto;

namespace CartService.Services.Cart;

public interface ICartService
{
    Task<CartDto?> GetAsync(string cartId);

    Task<CartDto> GetOrCreateAsync(string cartId);

    bool Delete(string cartId);

    Task<CartDto> AddProductAsync(string cartId, int productId, int count = 1);

    bool DeleteProduct(string cartId, int productId, int? count = null);
}
