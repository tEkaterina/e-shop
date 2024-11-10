using CartService.DataAccess.Common.Exceptions;
using LiteDB;

namespace CartService.DataAccess.LiteDb
{
    internal class DbInstance(string connectionString) : IDbInstance
    {
        public T Execute<T>(Func<LiteDatabase, T> action)
        {
            if (string.IsNullOrEmpty(connectionString))
            {
                throw new DbConfigurationException();
            }

            using var db = new LiteDatabase(connectionString);
            return action(db);
        }
    }
}
