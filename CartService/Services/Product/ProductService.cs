using CartService.DataAccess.Common.Entities;
using CartService.DataAccess.Repository.Product;
using CartService.Services.Common.Dto;
using CartService.Services.Events.ProductChanged;
using CartService.Services.Product.Mappers;

namespace CartService.Services.Product;

internal class ProductService(IProductRepository repository, IProductMapper mapper) : IProductService
{
    public ProductDto GetProduct(int productId)
    {
        ProductEntity? product = repository.GetProduct(productId);

        Guard.Against.NotFound(productId, product);

        return mapper.ToProductDto(product);
    }

    public void CreateOrSaveProduct(ProductDto product)
    {
        ProductEntity mappedProduct = mapper.ToProduct(product);
        repository.SaveProduct(mappedProduct);
    }
}
