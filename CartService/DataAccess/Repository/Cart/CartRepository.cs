using CartService.DataAccess.Common.Entities;
using CartService.DataAccess.LiteDb;

namespace CartService.DataAccess.Repository.Cart
{
    public class CartRepository(IDbContext _db) : ICartRepository
    {
        public bool SaveCart(CartEntity cart)
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
            });
        }

        public bool Exists(string id)
        {
            return _db.RunOnCarts((carts) =>
            {
                return carts.FindById(id) != null;
            });
        }

        public CartEntity? GetCart(string id)
        {
            return _db.RunOnCarts((carts) =>
            {
                return carts.FindById(id);
            });
        }
    }
}
