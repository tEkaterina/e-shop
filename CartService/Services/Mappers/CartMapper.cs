using CartService.Services.Dto;
using CartService.DataAccess.Entities;
using CartService.Services.Product;

namespace CartService.Services.Mappers;

public class CartMapper(IProductService productService) : ICartMapper
{
    private readonly IProductService _productService = productService;

    public CartEntity ToCart(CartDto cartDto)
    {
        return new CartEntity()
        {
            Id = cartDto.Id,
            UserId = cartDto.UserId,
            ProductItems = cartDto.Products.Select(ToProductItem).ToList(),
        };
    }

    public ProductItemEntity ToProductItem(ProductDto productDto)
    {
        return new ProductItemEntity(productDto.Id) { Count = productDto.Count };
    }

    public async Task<CartDto> ToCartDtoAsync(CartEntity cart)
    {
        IEnumerable<ProductDto> products;
        if (cart.ProductItems.Count > 0)
        {
            var mappedProducts = await Task.WhenAll(cart.ProductItems.Select(ToProductDtoAsync));
            products = mappedProducts.Where(x => x != null).Select(x => x!);
        }
        else
        {
            products = [];
        }

        return new CartDto() { Id = cart.Id, UserId = cart.UserId, Products = products };
    }

    public async Task<ProductDto?> ToProductDtoAsync(ProductItemEntity productDto)
    {
        var product = await _productService.GetProductAsync(productDto.Id);
        if (product != null)
        {
            product.Count = productDto.Count;
        }

        return product;
    }
}
