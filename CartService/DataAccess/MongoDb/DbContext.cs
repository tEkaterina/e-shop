using CartService.DataAccess.Common.Db;
using CartService.DataAccess.Common.Entities;

using MongoDB.Driver;

namespace CartService.DataAccess.MongoDb;

public class DbContext(IDbInstance db, DbConfig config) : IDbContext
{
    public T RunOnCarts<T>(Func<IMongoCollection<CartEntity>, T> action)
    {
        return db.Execute(x => action(x.GetCollection<CartEntity>(config.CartCollectionName)));
    }

    public T RunOnProducts<T>(Func<IMongoCollection<ProductEntity>, T> action)
    {
        return db.Execute(x => action(x.GetCollection<ProductEntity>(config.ProductCollectionName)));
    }
}
