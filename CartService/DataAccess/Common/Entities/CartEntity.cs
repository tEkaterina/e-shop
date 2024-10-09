namespace CartService.DataAccess.Common.Entities;

public record CartEntity() : BaseEntity
{
    public string? UserId { get; set; }

    public IList<ProductItemEntity> ProductItems { get; init; } = [];
}
