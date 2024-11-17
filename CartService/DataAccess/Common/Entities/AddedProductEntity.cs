namespace CartService.DataAccess.Common.Entities
{
    public record AddedProductEntity
    {
        public int ProductId { get; init; }
        public int Count { get; set; }
    }
}
