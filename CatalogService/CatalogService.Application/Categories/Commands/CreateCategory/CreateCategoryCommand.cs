namespace CatalogService.Application.Categories.Commands.CreateCategory;

public record CreateCategoryCommand() : IRequest<int>
{
    public string Name { get; init; } = string.Empty;

    public string? Image {  get; init; }

    public int? ParentCategoryId {  get; init; }
}
