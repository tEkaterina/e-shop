using CartService.DataAccess.Common.Db;
using CartService.DataAccess.Common.Entities;

using MongoDB.Driver;

namespace CartService.DataAccess.Repository.Product;

public class ProductRepository(IDbContext _db) : IProductRepository
{
    public bool DeleteProduct(int id)
    {
        return _db.RunOnProducts((products) => products.DeleteOne(GetFilterById(id)).IsAcknowledged);
    }

    public ProductEntity? GetProduct(int id)
    {
        return _db.RunOnProducts((products) => Find(products, id));
    }

    public bool SaveProduct(ProductEntity product)
    {
        return _db.RunOnProducts((products) =>
        {
            if (Find(products, product.Id) != null)
            {
                return products.ReplaceOne(GetFilterById(product.Id), product).IsAcknowledged;
            }

            products.InsertOne(product);

            return true;
        });
    }

    public bool Exists(int id)
    {
        return _db.RunOnProducts((products) => Find(products, id) != null);
    }

    private ProductEntity? Find(IMongoCollection<ProductEntity> carts, int id)
    {
        return carts.FindSync(GetFilterById(id)).FirstOrDefault();
    }

    private FilterDefinition<ProductEntity> GetFilterById(int id) => Builders<ProductEntity>.Filter.Eq(x => x.Id, id);
}
