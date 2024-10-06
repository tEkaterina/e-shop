using CartService.Services.Dto;
using CartService.DataAccess.Entities;

namespace CartService.Services.Mappers;

public interface ICartMapper
{
    CartEntity ToCart(CartDto cartDto);
    ProductItemEntity ToProductItem(ProductDto productDto);

    Task<CartDto> ToCartDtoAsync(CartEntity cart);
    Task<ProductDto?> ToProductDtoAsync(ProductItemEntity productDto);
}
