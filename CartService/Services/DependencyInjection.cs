using CartService.Services.Cart;
using CartService.Services.Cart.Mappers;
using CartService.Services.Product;
using CartService.Services.Product.Mappers;

namespace CartService.Services;

public static class DependencyInjection
{
    public static IServiceCollection AddApplicationServices(this IServiceCollection services)
    {
        services.AddTransient<ICartService, Cart.CartService>();
        services.AddTransient<ICartMapper, CartMapper>();
        services.AddTransient<IProductService, ProductService>();
        services.AddTransient<IProductMapper, ProductMapper>();

        return services;
    }
}
