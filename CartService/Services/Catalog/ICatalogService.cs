namespace CartService.Services.Catalog;

public interface ICatalogService
{
    Task<CatalogProduct?> GetAsync(int id);
}
