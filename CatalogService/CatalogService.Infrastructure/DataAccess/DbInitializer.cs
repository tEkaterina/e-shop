using Microsoft.EntityFrameworkCore;

namespace CatalogService.Infrastructure.DataAccess;

public class DbInitializer(ApplicationDbContext context) : IDbInitializer
{
    public async Task InitializeAsync()
    {
        await context.Database.MigrateAsync();
    }
}
