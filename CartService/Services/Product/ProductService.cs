using CartService.DataAccess.Common.Entities;
using CartService.DataAccess.Repository.Product;
using CartService.Services.Common.Dto;
using CartService.Services.Product.Mappers;

namespace CartService.Services.Product;

public class ProductService(IProductRepository _repository, IProductMapper _mapper) : IProductService
{
    public ProductDto GetProduct(int productId)
    {
        ProductEntity product = _repository.GetProduct(productId);

        Guard.Against.NotFound(productId, product);

        return _mapper.ToProductDto(product);
    }

    public void CreateOrSaveProduct(ProductDto product)
    {
        ProductEntity mappedProduct = _mapper.ToProduct(product);
        _repository.SaveProduct(mappedProduct);
    }
}
