namespace CartService.DataAccess.Common.Entities;

public record ProductEntity(int Id)
{
    public required string Name { get; set; }

    public required decimal Price { get; set; }

    public string? Description { get; set; }

    public string? Image { get; set; }
}
