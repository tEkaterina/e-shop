using CartService.DataAccess.LiteDb;
using CartService.DataAccess.Repository;

namespace CartService.DataAccess.Extentions
{
    public static class DependencyInjection
    {
        public static IServiceCollection AddDataAccessServices(this IServiceCollection services, IConfiguration config)
        {
            services.Configure<LiteDbOptions>(config.GetSection("LiteDbOptions"));
            services.AddSingleton<IDbContext, DbContext>();

            services.AddScoped<ICartRepository, CartRepository>();

            return services;
        }
    }
}
