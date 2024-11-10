using CartService.Services.Product;
using CartService.Services.Common.Dto;
using CartService.DataAccess.Common.Entities;

namespace CartService.Services.Cart.Mappers;

public class CartMapper(IProductService productService) : ICartMapper
{
    private readonly IProductService _productService = productService;

    public CartEntity ToCart(CartDto cartDto)
    {
        return new CartEntity(cartDto.Id)
        {
            Products = cartDto.Products.Select(ToAddedProduct).ToList(),
        };
    }

    public AddedProductEntity ToAddedProduct(ProductDto productDto)
    {
        return new AddedProductEntity { ProductId = productDto.Id, Count = productDto.Count };
    }

    public CartDto ToCartDto(CartEntity cart)
    {
        IEnumerable<ProductDto> products;
        if (cart.Products.Count > 0)
        {
            var mappedProducts = cart.Products.Select(ToProductDto);
            products = mappedProducts.Where(x => x != null).Select(x => x!);
        }
        else
        {
            products = [];
        }

        return new CartDto(cart.Id) { Products = products };
    }

    public ProductDto? ToProductDto(AddedProductEntity cartProduct)
    {
        var product = _productService.GetProduct(cartProduct.ProductId);
        if (product != null)
        {
            product.Count = cartProduct.Count;
        }

        return product;
    }
}
