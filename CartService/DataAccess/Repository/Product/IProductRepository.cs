using CartService.DataAccess.Common.Entities;

namespace CartService.DataAccess.Repository.Product;

public interface IProductRepository
{
    public ProductEntity? GetProduct(int id);

    public bool DeleteProduct(int id);

    public bool SaveProduct(ProductEntity product);

    bool Exists(int id);
}