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
            services.AddSingleton<IDbContext>(new DbContext(":memory:"));
        });
    }
}