using CartService.DataAccess.Common.Entities;
using CartService.Services.Common.Dto;

namespace CartService.Services.Cart.Mappers;

public interface ICartMapper
{
    CartEntity ToCart(CartDto cartDto);
    AddedProductEntity ToAddedProduct(ProductDto productDto);

    CartDto ToCartDto(CartEntity cart);
    ProductDto? ToProductDto(AddedProductEntity product);
}
