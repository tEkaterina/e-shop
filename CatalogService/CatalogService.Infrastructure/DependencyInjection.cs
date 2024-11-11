using CatalogService.Application.Common.Interfaces;
using CatalogService.Infrastructure.DataAccess;
using EShop.MessageBrokerClient;
using EShop.MessageBrokerClient.Configuration;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace CatalogService.Infrastructure;

public static class DependencyInjection
{
    public static IServiceCollection AddInfrastructureServices(this IServiceCollection services, IConfiguration configuration)
    {
        var connectionString = configuration.GetConnectionString("DefaultConnection");

        Guard.Against.NullOrEmpty(connectionString);

        services.AddDbContext<ApplicationDbContext>(options =>
        {
            options.UseSqlite(connectionString);
        });

        services.AddScoped<IApplicationDbContext>(options => options.GetRequiredService<ApplicationDbContext>());
        services.AddScoped<IDbInitializer, DbInitializer>();

        services.AddMessageBroker(configuration);

        return services;
    }
}
