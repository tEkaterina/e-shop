using CartService.DataAccess.LiteDb;
using CartService.DataAccess.Models;

namespace CartService.DataAccess.Repository
{
    public class CartRepository(IDbContext db) : ICartRepository
    {
        private readonly IDbContext _db = db;


        public bool SaveCart(Cart cart)
        {
            return _db.RunOnCarts((carts) =>
            {
                if (carts.FindById(cart.Id) != null)
                {
                    return carts.Update(cart);
                }

                carts.Insert(cart);

                return true;
            });
        }

        public bool DeleteCart(string id)
        {
            return _db.RunOnCarts((carts) =>
            {
                return carts.Delete(id);
            }
            )
                ;
        }

        public bool Exists(string id)
        {
            return _db.RunOnCarts((carts) =>
            {
                return carts.FindById(id) != null;
            });
        }

        public Cart? GetCart(string id)
        {
            return _db.RunOnCarts((carts) =>
            {
                return carts.FindById(id);
            });
        }
    }
}