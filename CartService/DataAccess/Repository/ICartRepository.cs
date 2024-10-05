using CartService.DataAccess.Models;

namespace CartService.DataAccess.Repository
{
    public interface ICartRepository
    {
        public Cart? GetCart(string id);

        public bool DeleteCart(string id);

        public bool SaveCart(Cart cart);
    }
}
