namespace CatalogService.Domain.Entities;

public record Category
{
    public int Id { get; set; }

    public string Name { get; set; } = string.Empty;

    public string? Image { get; set; }

    public int? ParentCategoryId { get; set; }

    public Category? ParentCategory { get; set; }

    public IList<Category> ChildCategories { get; init; } = [];

    public IList<Product> Products { get; init; } = [];
}
