using CartService.DataAccess.Common.Entities;
using LiteDB;

namespace CartService.DataAccess.LiteDb
{
    public interface IDbContext
    {
        T RunOnCarts<T>(Func<ILiteCollection<CartEntity>, T> action);
        T RunOnProducts<T>(Func<ILiteCollection<ProductEntity>, T> action);
    }
}
