using LiteDB;

namespace CartService.DataAccess.LiteDb;

public class InMemoryDbInstance(string? connectionString) : IDbInstance, IDisposable
{
    private readonly LiteDatabase _instance = new LiteDatabase(connectionString);

    public T Execute<T>(Func<LiteDatabase, T> action)
    {
        return action(_instance);
    }

    public void Dispose()
    {
        Dispose(disposing: true);

        GC.SuppressFinalize(this);
    }

    private void Dispose(bool disposing)
    {
        if (disposing)
        {
            _instance.Dispose();
        }
    }

    ~InMemoryDbInstance()
    {
        Dispose(disposing: false);
    }
}
