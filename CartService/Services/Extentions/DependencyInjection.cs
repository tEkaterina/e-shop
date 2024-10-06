using CartService.Services.Cart;
using CartService.Services.Catalog;
using CartService.Services.Mappers;
using CartService.Services.Product;

namespace CartService.Services.Extentions;

public static class DependencyInjection
{
    public static IServiceCollection AddApplicationServices(this IServiceCollection services)
    {
        services.AddTransient<ICatalogService, CatalogService>();
        services.AddTransient<ICartService, Cart.CartService>();
        services.AddTransient<ICartMapper, CartMapper>();
        services.AddTransient<IProductService, ProductService>();

        return services;
    }
}
