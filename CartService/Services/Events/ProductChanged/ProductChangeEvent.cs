namespace CartService.Services.Events.ProductChanged;

public record ProductChangeEvent(int ProductId, ProductChangeDetails Details);

public record ProductChangeDetails
{
    public required string Name { get; init; }
    public required decimal Price { get; set; }
    public string? Description { get; init; }
    public string? Image { get; set; }
}
