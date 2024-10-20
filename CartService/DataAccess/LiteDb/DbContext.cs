using CartService.DataAccess.Common.Entities;
using CartService.DataAccess.Common.Exceptions;
using LiteDB;

namespace CartService.DataAccess.LiteDb
{
    public class DbContext : IDbContext
    {
        private readonly string _databasePath;

        public DbContext(string? connectionString)
        {
            if (string.IsNullOrEmpty(connectionString))
            {
                throw new DbConfigurationException();
            }

            _databasePath = connectionString;
        }

        public ILiteDatabase Get()
        {
            return new LiteDatabase(_databasePath);
        }

        public T RunOnCarts<T>(Func<ILiteCollection<CartEntity>, T> action)
        {
            using var db = Get();
            return action(db.GetCollection<CartEntity>("CartCollection"));
        }
    }
}
