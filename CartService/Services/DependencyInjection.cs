using CartService.Services.Authorization;
using CartService.Services.Cart;
using CartService.Services.Cart.Mappers;
using CartService.Services.Events.ProductChanged;
using CartService.Services.Product;
using CartService.Services.Product.Mappers;

namespace CartService.Services;

public static class DependencyInjection
{
    public static IServiceCollection AddApplicationServices(this IServiceCollection services, IConfiguration config)
    {
        services.AddTransient<ICartService, Cart.CartService>();
        services.AddTransient<ICartMapper, CartMapper>();
        services.AddTransient<IProductMapper, ProductMapper>();
        services.AddTransient<IProductService, ProductService>();

        services.AddHostedService<ProductChangeListener>();
        services.AddSingleton<IProductChangePublisher, ProductChangePublisher>();

        services.AddAuthorizationServices(config);

        return services;
    }
}
