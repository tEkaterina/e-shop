namespace CartService.DataAccess.Common.Entities;

public record CartEntity(string Id)
{
    public IList<AddedProductEntity> Products { get; init; } = [];
}
