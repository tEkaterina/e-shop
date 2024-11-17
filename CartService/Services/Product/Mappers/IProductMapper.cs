using CartService.DataAccess.Common.Entities;
using CartService.Services.Common.Dto;

namespace CartService.Services.Product.Mappers
{
    public interface IProductMapper
    {
        public ProductDto ToProductDto(ProductEntity product);

        public ProductEntity ToProduct(ProductDto productDto);
    }
}