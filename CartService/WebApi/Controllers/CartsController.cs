using CartService.Services.Cart;
using CartService.Services.Dto;
using CartService.Services.Exceptions;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace CartService.WebApi.Controllers;

public record ModifyProductCountRequest(int ProductId, int Count = 1);
public record CreateCartRequest(string Id);

[Route("api/[controller]")]
[ApiController]
public class CartsController(ICartService cartService) : ControllerBase
{
    private readonly ICartService _cartService = cartService;

    [HttpGet("{id}")]
    public async Task<IActionResult> Get(string id)
    {
        CartDto? cart = await _cartService.GetAsync(id);
        if (cart == null)
        {
            return NotFound(id);
        }

        return Ok(cart);
    }

    [HttpPost]
    public async Task<IActionResult> Post([FromBody] CreateCartRequest request)
    {
        CartDto cart = await _cartService.GetOrCreateAsync(request.Id);

        return Ok(cart);
    }

    [HttpDelete("{id}")]
    public IActionResult Delete(string id)
    {
        if (!_cartService.Delete(id))
        {
            return NotFound(id);
        }

        return NoContent();
    }

    [HttpGet("{cartId}/products")]
    public async Task<IActionResult> GetProducts(string cartId)
    {
        CartDto? cart = await _cartService.GetAsync(cartId);

        if (cart == null)
        {
            return NotFound(cartId);
        }

        return Ok(cart.Products);
    }

    [HttpPost("{cartId}/products")]
    public async Task<IActionResult> AddProduct(string cartId, [FromBody] ModifyProductCountRequest request)
    {
        try
        {
            CartDto cart = await _cartService.AddProductAsync(cartId, request.ProductId, request.Count);
            return Ok(cart.Products);
        }
        catch (ProductNotFoundException)
        {
            return BadRequest("The provided product does not exist: " + request.ProductId);
        }
    }

    [HttpDelete("{cartId}/products/{productId}")]
    public IActionResult RemoveProduct(string cartId, int productId, [FromQuery] int? count)
    {
        try
        {
            _cartService.DeleteProduct(cartId, productId, count);
            return NoContent();
        }
        catch (ProductNotFoundException)
        {
            return BadRequest($"Unable to find {productId}.");
        }
        catch (CartNotFoundException)
        {
            return NotFound(cartId);
        }
    }
}
