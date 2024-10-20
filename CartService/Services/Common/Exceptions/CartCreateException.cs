namespace CartService.Services.Common.Exceptions
{
    public class CartCreateException(string id) : Exception($"Failed to create Cart {id}.")
    {
    }
}
