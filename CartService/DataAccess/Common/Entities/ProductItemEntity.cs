namespace CartService.DataAccess.Common.Entities;

public record ProductItemEntity(int Id)
{
    public int Count { get; set; }
}
