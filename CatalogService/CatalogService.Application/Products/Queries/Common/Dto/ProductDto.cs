namespace CatalogService.Application.Products.Queries.Common.Dto
{
    public record ProductDto(int Id, string Name, decimal Price, int Amount, int CategoryId,
        string? Description = null, string? Image = null);
}
