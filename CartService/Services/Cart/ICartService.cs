using CartService.Services.Common.Dto;

namespace CartService.Services.Cart;

public interface ICartService
{
    CartDto Get(string cartId);

    CartDto GetOrCreate(string cartId);

    bool Delete(string cartId);

    CartDto AddProduct(string cartId, int productId, int count = 1);

    bool DeleteProduct(string cartId, int productId, int? count = null);
}
