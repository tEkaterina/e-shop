using LiteDB;

namespace CartService.DataAccess.LiteDb
{
    public interface IDbInstance
    {
        public T Execute<T>(Func<LiteDatabase, T> action);
    }
}
