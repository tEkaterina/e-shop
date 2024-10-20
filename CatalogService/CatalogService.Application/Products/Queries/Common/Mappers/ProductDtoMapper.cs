using CatalogService.Application.Products.Queries.Common.Dto;

namespace CatalogService.Application.Products.Queries.Common.Mappers
{
    internal static class ProductDtoMapper
    {
        internal static Product ToProduct(this ProductDto productDto)
        {
            return new Product
            {
                Id = productDto.Id,
                Name = productDto.Name,
                Amount = productDto.Amount,
                CategoryId = productDto.CategoryId,
                Description = productDto.Description,
                Image = productDto.Image,
                Price = productDto.Price,
            };
        }

        internal static ProductDto ToProductDto(this Product product)
        {
            return new ProductDto(
                product.Id,
                product.Name,
                product.Price,
                product.Amount,
                product.CategoryId,
                product.Description,
                product.Image
             );
        }
    }
}
