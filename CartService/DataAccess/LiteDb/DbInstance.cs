using CartService.DataAccess.Common.Exceptions;

using LiteDB;

namespace CartService.DataAccess.LiteDb;

internal class DbInstance : IDbInstance
{
    private readonly string _connectionString;

    public DbInstance(string? connectionString)
    {
        if (string.IsNullOrEmpty(connectionString))
        {
            throw new DbConfigurationException();
        }

        _connectionString = connectionString;
    }

    public T Execute<T>(Func<LiteDatabase, T> action)
    {
        using var db = new LiteDatabase(_connectionString);
        return action(db);
    }
}
