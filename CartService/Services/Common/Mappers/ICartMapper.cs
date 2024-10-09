using CartService.DataAccess.Common.Entities;
using CartService.Services.Common.Dto;

namespace CartService.Services.Common.Mappers;

public interface ICartMapper
{
    CartEntity ToCart(CartDto cartDto);
    ProductItemEntity ToProductItem(ProductDto productDto);

    Task<CartDto> ToCartDtoAsync(CartEntity cart);
    Task<ProductDto?> ToProductDtoAsync(ProductItemEntity productDto);
}
