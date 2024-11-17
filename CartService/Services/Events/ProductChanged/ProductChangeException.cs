namespace CartService.Services.Events.ProductChanged;

public class ProductChangeException(string reason): Exception($"Failed to handle product change event: {reason}");
