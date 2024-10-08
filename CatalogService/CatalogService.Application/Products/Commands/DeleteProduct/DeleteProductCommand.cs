namespace CatalogService.Application.Products.Commands.DeleteProduct;

public record DeleteProductCommand(int Id) : IRequest;
