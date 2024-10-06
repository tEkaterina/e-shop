
namespace CartService.Services.Catalog;

public class CatalogService : ICatalogService
{
    public Task<CatalogProduct?> GetAsync(int id)
    {
        return Task.Run(() => new CatalogProduct(id, $"Temp Name for {id}"));
    }
}
