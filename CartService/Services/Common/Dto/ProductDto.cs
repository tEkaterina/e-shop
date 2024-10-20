namespace CartService.Services.Common.Dto
{
    public record ProductDto(int Id, string Name)
    {
        public int Count { get; set; }

        public string? Description { get; init; }

        public string? Image { get; init; }

        public decimal Price { get; init; }
    }
}
