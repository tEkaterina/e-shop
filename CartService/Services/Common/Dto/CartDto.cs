namespace CartService.Services.Common.Dto;

public record CartDto(string Id)
{
    public IEnumerable<ProductDto> Products { get; init; } = [];
}
