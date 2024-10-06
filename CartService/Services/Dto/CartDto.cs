namespace CartService.Services.Dto
{
    public record CartDto
    {
        public string Id { get; init; } = Guid.NewGuid().ToString();
        public string? UserId { get; init; }

        public IEnumerable<ProductDto> Products { get; init; } = [];
    }
}
