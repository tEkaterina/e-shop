using CartService.DataAccess.LiteDb;
using CartService.DataAccess.Repository;

namespace CartService.DataAccess.Extentions
{
    public static class DependencyInjection
    {
        public static IServiceCollection AddDataAccessServices(this IServiceCollection services, IConfiguration config)
        {
            services.AddSingleton<IDbContext>(new DbContext(config.GetConnectionString("LiteDb")));

            services.AddScoped<ICartRepository, CartRepository>();

            return services;
        }
    }
}
