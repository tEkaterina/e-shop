namespace CartService.Services.Events.ProductChanged;

public record ProductChangeEventPayload(int ProductId, ProductChangeDetails Details);
