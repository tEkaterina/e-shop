namespace CartService.DataAccess.Entities;

public record ProductItemEntity(int Id)
{
    public int Count { get; set; }
}
