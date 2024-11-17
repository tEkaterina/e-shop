using CartService.Services.Common.Dto;

namespace CartService.Services.Product
{
    public interface IProductService
    {
        ProductDto GetProduct(int productId);

        void CreateOrSaveProduct(ProductDto product);
    }
}
