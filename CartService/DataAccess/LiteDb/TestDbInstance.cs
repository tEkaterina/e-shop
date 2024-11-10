using LiteDB;

namespace CartService.DataAccess.LiteDb
{
    public class TestDbInstance(string connectionString) : IDbInstance
    {
        private readonly LiteDatabase _instance = new LiteDatabase(connectionString);

        public T Execute<T>(Func<LiteDatabase, T> action)
        {
            return action(_instance);
        }
    }
}
