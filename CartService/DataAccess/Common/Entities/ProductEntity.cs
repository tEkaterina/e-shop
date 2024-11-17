using LiteDB;

namespace CartService.DataAccess.Common.Entities;

public record ProductEntity(int Id)
{
    public string Name { get; set; }

    public decimal Price { get; set; }

    public string? Description { get; set; }

    public string? Image { get; set; }
}
