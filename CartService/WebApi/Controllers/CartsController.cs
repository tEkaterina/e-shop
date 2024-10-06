using CartService.Services.Cart;
using CartService.Services.Dto;
using CartService.Services.Exceptions;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace CartService.WebApi.Controllers;

public record ModifyProductCountRequest(int ProductId, int Count = 1);

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
            return NotFound();
        }

        return Ok(cart);
    }

    [HttpPost]
    public async Task<IActionResult> Post([FromBody] string cartId)
    {
        CartDto cart = await _cartService.GetOrCreateAsync(cartId);

        return Ok(cart);
    }

    [HttpDelete("{id}")]
    public IActionResult Delete(string id)
    {
        if (!_cartService.Delete(id))
        {
            return NotFound();
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
            return Ok(cart);
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
            return BadRequest();
        }
        catch (CartNotFoundException)
        {
            return NotFound();
        }
    }
}
