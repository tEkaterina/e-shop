using CartService.DataAccess.Models;
using LiteDB;

namespace CartService.DataAccess.LiteDb
{
    public interface IDbContext
    {
        ILiteDatabase Get();
        T RunOnCarts<T>(Func<ILiteCollection<Cart>, T> action);
    }
}
