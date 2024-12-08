using MongoDB.Driver;

namespace CartService.DataAccess.Common.Db;

public interface IDbInstance
{
    public T Execute<T>(Func<IMongoDatabase, T> action);
}
