using System.Diagnostics;

namespace CatalogService.Domain.Entities;

public record Product(int Id, string Name, decimal Price, Category Category)
{
    public string? Description { get; set; }

    public string? Image {  get; set; }

    public int Amount { get; set; }
}
