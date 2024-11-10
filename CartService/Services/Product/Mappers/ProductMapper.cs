using CartService.DataAccess.Common.Entities;
using CartService.Services.Common.Dto;

namespace CartService.Services.Product.Mappers;

internal class ProductMapper : IProductMapper
{
    public ProductEntity ToProduct(ProductDto productDto)
    {
        return new ProductEntity(productDto.Id)
        {
            Name = productDto.Name,
            Description = productDto.Description,
            Image = productDto.Image,
            Price = productDto.Price,
        };
    }

    public ProductDto ToProductDto(ProductEntity product)
    {
        return new ProductDto(product.Id, product.Name)
        {
            Description = product.Description,
            Image = product.Image,
            Price = product.Price,
        };
    }
}
