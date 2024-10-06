using CartService.DataAccess.Entities;
using LiteDB;

namespace CartService.DataAccess.LiteDb
{
    public interface IDbContext
    {
        ILiteDatabase Get();
        T RunOnCarts<T>(Func<ILiteCollection<CartEntity>, T> action);
    }
}
