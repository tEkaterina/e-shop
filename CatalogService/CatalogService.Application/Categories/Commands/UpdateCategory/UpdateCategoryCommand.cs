namespace CatalogService.Application.Categories.Commands.UpdateCategory;

public record UpdateCategoryCommand(int Id, string Name, string? Image, int? ParentCategoryId) : IRequest;
