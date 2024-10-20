namespace CartService.Services.Catalog;

public record CatalogProduct(int Id, string Name)
{
    public string? Description { get; init; }

    public string? ImageUrl { get; init; }

    public decimal Price { get; init; }
}
