namespace CatalogService.Domain.Entities;

public record Product
{
    public int Id { get; set; }

    public string Name { get; set; } = string.Empty;

    public decimal Price { get; set; }

    public string? Description { get; set; }

    public string? Image { get; set; }

    public int Amount { get; set; }

    public int CategoryId { get; set; }

    public Category Category { get; set; } = null!;
}
