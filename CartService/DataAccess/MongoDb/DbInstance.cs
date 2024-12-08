using CartService.DataAccess.Common.Db;
using CartService.DataAccess.Common.Exceptions;

using MongoDB.Driver;

namespace CartService.DataAccess.MongoDb;

public class DbInstance : IDbInstance
{
    private readonly string _connectionString;
    private readonly DbConfig _config;

    public DbInstance(string? connectionString, DbConfig config)
    {
        if (string.IsNullOrEmpty(connectionString))
        {
            throw new DbConfigurationException();
        }

        _connectionString = connectionString;
        _config = config;
    }

    public T Execute<T>(Func<IMongoDatabase, T> action)
    {
        var client = new MongoClient(_connectionString);
        IMongoDatabase db = client.GetDatabase(_config.DbName);

        return action(db);
    }
}
