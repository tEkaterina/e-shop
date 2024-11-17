namespace CatalogService.Application.Products.Commands.UpdateProduct;

public record UpdateProductCommand(
    int Id,
    string Name,
    int CategoryId,
    decimal Price,
    int Amount) : IRequest
{
    public string? Description { get; init; }
    public string? Image { get; init; }
}
