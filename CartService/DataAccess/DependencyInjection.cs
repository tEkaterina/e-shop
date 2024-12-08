using CartService.DataAccess.Common.Db;
using CartService.DataAccess.MongoDb;
using CartService.DataAccess.Repository.Cart;
using CartService.DataAccess.Repository.Product;

using EShop.MessageBrokerClient;

namespace CartService.DataAccess;

public static class DependencyInjection
{
    public static IServiceCollection AddDataAccessServices(this IServiceCollection services, IConfiguration config)
    {
        var connectionString = config.GetConnectionString("DefaultConnection");
        DbConfig dbConfig = config.GetSection(DbConfigPath.Config).Get<DbConfig>()
            ?? throw new ApplicationException("Failed to initialize database configuration.");

        services.AddSingleton(dbConfig);
        services.AddSingleton<IDbInstance>(new DbInstance(connectionString, dbConfig));

        services.AddSingleton<IDbContext, DbContext>();
        services.AddSingleton<ICartRepository, CartRepository>();
        services.AddSingleton<IProductRepository, ProductRepository>();

        services.AddMessageBroker(config);

        return services;
    }
}
