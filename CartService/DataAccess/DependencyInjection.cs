using CartService.DataAccess.LiteDb;
using CartService.DataAccess.Repository.Cart;
using CartService.DataAccess.Repository.Product;

namespace CartService.DataAccess
{
    public static class DependencyInjection
    {
        public static IServiceCollection AddDataAccessServices(this IServiceCollection services, IConfiguration config, IWebHostEnvironment env)
        {
            var connectionString = config.GetConnectionString("LiteDb");

            if (env.IsEnvironment("Test"))
            {
                services.AddSingleton<IDbInstance>(new TestDbInstance(connectionString));
            }
            else
            {
                services.AddSingleton<IDbInstance>(new DbInstance(connectionString));
            }

            services.AddScoped<IDbContext, DbContext>();
            services.AddScoped<ICartRepository, CartRepository>();
            services.AddScoped<IProductRepository, ProductRepository>();

            return services;
        }
    }
}
