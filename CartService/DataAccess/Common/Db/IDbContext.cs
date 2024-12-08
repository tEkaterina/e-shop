using CartService.DataAccess.Common.Entities;

using MongoDB.Driver;

namespace CartService.DataAccess.Common.Db
{
    public interface IDbContext
    {
        T RunOnCarts<T>(Func<IMongoCollection<CartEntity>, T> action);
        T RunOnProducts<T>(Func<IMongoCollection<ProductEntity>, T> action);
    }
}
