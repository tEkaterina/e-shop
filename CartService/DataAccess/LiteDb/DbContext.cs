using CartService.DataAccess.Entities;
using CartService.DataAccess.Exceptions;
using LiteDB;
using Microsoft.Extensions.Options;

namespace CartService.DataAccess.LiteDb
{
    public class DbContext : IDbContext
    {
        private readonly string _databasePath;

        public DbContext(IOptions<LiteDbOptions> options)
        {
            if (string.IsNullOrEmpty(options.Value.ConnectionString))
            {
                throw new DbConfigurationException();
            }

            _databasePath = options.Value.ConnectionString;
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
