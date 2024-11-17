using CartService.DataAccess.Common.Entities;
using LiteDB;

namespace CartService.DataAccess.LiteDb;

public class DbContext(IDbInstance db) : IDbContext
{
    public T RunOnCarts<T>(Func<ILiteCollection<CartEntity>, T> action)
    {
        return db.Execute(x => action(x.GetCollection<CartEntity>("CartCollection")));
    }

    public T RunOnProducts<T>(Func<ILiteCollection<ProductEntity>, T> action)
    {
        return db.Execute(x => action(x.GetCollection<ProductEntity>("ProductItemCollection")));
    }
}
