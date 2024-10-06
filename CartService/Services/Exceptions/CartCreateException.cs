namespace CartService.Services.Exceptions
{
    public class CartCreateException(string id) : Exception($"Failed to create Cart {id}.")
    {
    }
}
