using CartService.DataAccess.Common.Entities;

namespace CartService.DataAccess.Repository.Cart
{
    public interface ICartRepository
    {
        public CartEntity? GetCart(string id);

        public bool DeleteCart(string id);

        public bool SaveCart(CartEntity cart);

        public bool Exists(string id);
    }
}
