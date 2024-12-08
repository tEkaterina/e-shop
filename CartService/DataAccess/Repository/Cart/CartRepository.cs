using CartService.DataAccess.Common.Db;
using CartService.DataAccess.Common.Entities;

using MongoDB.Driver;

namespace CartService.DataAccess.Repository.Cart
{
    public class CartRepository(IDbContext _db) : ICartRepository
    {
        public bool SaveCart(CartEntity cart)
        {
            return _db.RunOnCarts((carts) =>
            {
                if (Find(carts, cart.Id) != null)
                {
                    return carts.ReplaceOne(GetFilterById(cart.Id), cart).IsAcknowledged;
                }

                carts.InsertOne(cart);

                return true;
            });
        }

        public bool DeleteCart(string id)
        {
            return _db.RunOnCarts((carts) =>
            {
                return carts.DeleteOne(GetFilterById(id)).IsAcknowledged;
            });
        }

        public bool Exists(string id)
        {
            return _db.RunOnCarts((carts) => Find(carts, id) != null);
        }

        public CartEntity? GetCart(string id)
        {
            return _db.RunOnCarts((carts) => Find(carts, id));
        }

        private CartEntity? Find(IMongoCollection<CartEntity> carts, string id)
        {
            return carts.FindSync(GetFilterById(id)).FirstOrDefault();
        }

        private FilterDefinition<CartEntity> GetFilterById(string id) => Builders<CartEntity>.Filter.Eq(x => x.Id, id);
    }
}
