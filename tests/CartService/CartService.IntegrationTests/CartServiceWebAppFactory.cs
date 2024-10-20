using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc.Testing;
using CartService.DataAccess.LiteDb;
using Microsoft.Extensions.DependencyInjection;

namespace CartService.IntegrationTests;

public class CartServiceWebAppFactory : WebApplicationFactory<Program>
{
    protected override void ConfigureWebHost(IWebHostBuilder builder)
    {
        builder.ConfigureServices(services =>
        {
            var dbContext = services.Single(x => x.ServiceType == typeof(IDbContext));
            services.Remove(dbContext);

            services.AddSingleton<IDbContext>(new DbContext(":memory:"));
        });

        builder.UseEnvironment("Development");
    }
}