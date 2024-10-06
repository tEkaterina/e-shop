namespace CartService.Services.Exceptions
{
    public class CartNotFoundException(string id): Exception($"Cart with the given id {id} is not found.")
    {
    }
}
