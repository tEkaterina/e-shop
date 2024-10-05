namespace CartService.DataAccess.Models;

public class Cart : BaseEntity
{
    public string? UserID { get; set; }

    public IList<ProductItem> ProductItems { get; private set; } = [];
}
