namespace CatalogService.Application.Products.Commands.CreateProduct;

public record CreateProductCommand(
    string Name,
    int CategoryId,
    decimal Price,
    int Amount) : IRequest<int>
{
    public string? Description { get; init; }
    public string? Image { get; init; }
}
