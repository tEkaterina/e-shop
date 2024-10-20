namespace CartService.DataAccess.Common.Entities;

public record BaseEntity
{
    public string Id { get; set; } = Guid.NewGuid().ToString();
}
