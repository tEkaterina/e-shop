using CartService.DataAccess.Common.Entities;
using CartService.DataAccess.LiteDb;
using CartService.DataAccess.Repository.Product;

namespace CartService.DataAccess.Repository.Product
{
    public class ProductRepository(IDbContext _db) : IProductRepository
    {
        public bool DeleteProduct(int id)
        {
            return _db.RunOnProducts((products) =>
            {
                return products.Delete(id);
            });
        }

        public ProductEntity? GetProduct(int id)
        {
            return _db.RunOnProducts((products) =>
            {
                return products.FindById(id);
            });
        }

        public bool SaveProduct(ProductEntity product)
        {
            return _db.RunOnProducts((products) =>
            {
                if (products.FindById(product.Id) != null)
                {
                    return products.Update(product);
                }

                products.Insert(product);

                return true;
            });
        }

        public bool Exists(int id)
        {
            return _db.RunOnProducts((products) =>
            {
                return products.FindById(id) != null;
            });
        }
    }
}
