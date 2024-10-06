namespace CartService.Services.Dto
{
    public record ProductDto(int Id, string Name)
    {
        public int Count { get; set; }

        public string? Description { get; init; }

        public string? ImageUrl { get; init; }

        public decimal? Price { get; init; }
    }
}
