using CartService.DataAccess.Entities;

namespace CartService.DataAccess.Repository
{
    public interface ICartRepository
    {
        public CartEntity? GetCart(string id);

        public bool DeleteCart(string id);

        public bool SaveCart(CartEntity cart);
    }
}
