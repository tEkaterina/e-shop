﻿using CartService.Services.Cart;
using CartService.Services.Common.Dto;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace CartService.WebApi.Controllers;

public record ModifyProductCountRequest(int ProductId, int Count = 1);
public record CreateCartRequest(string Id);

[Route("api/[controller]")]
[ApiVersion("1.0")]
[ApiVersion("2.0")]
[ApiController]
public class CartsController(ICartService cartService) : ControllerBase
{
    private readonly ICartService _cartService = cartService;

    /// <summary>
    /// Provides content of the provided cart
    /// </summary>
    /// <param name="id">The cart ID</param>
    /// <returns>A set of products included into cart</returns>
    /// <response code="200">Returns the required cart products</response>
    /// <response code="404">The provided cart does not exist</response>
    [ApiVersion("2.0")]
    [MapToApiVersion("2.0")]
    [HttpGet("{id}")]
    public async Task<IActionResult> GetCartProducts(string id)
    {
        try
        {
            CartDto cart = await _cartService.GetAsync(id);
            return Ok(cart.Products);
        }
        catch (NotFoundException)
        {
            return NotFound("The provided cart does not exist: " + id);
        }
    }

    /// <summary>
    /// Provides details of the specified cart
    /// </summary>
    /// <param name="id">The retrieving cart</param>
    /// <returns>Details of the cart and its products</returns>
    /// <response code="200">Returns the required cart details</response>
    /// <response code="404">The provided cart does not exist</response>
    [ApiVersion("1.0")]
    [MapToApiVersion("1.0")]
    [HttpGet("{id}")]
    public async Task<IActionResult> Get(string id)
    {
        try
        {
            CartDto cart = await _cartService.GetAsync(id);
            return Ok(cart);
        }
        catch (NotFoundException)
        {
            return NotFound("The provided cart does not exist: " + id);
        }
    }

    /// <summary>
    /// Creates a new cart
    /// </summary>
    /// <param name="request">Details for a cart creation</param>
    /// <returns>Details of the created cart</returns>
    /// <response code="200">Cart was added</response>
    [HttpPost]
    public async Task<IActionResult> Post([FromBody] CreateCartRequest request)
    {
        CartDto cart = await _cartService.GetOrCreateAsync(request.Id);

        return Ok(cart);
    }

    /// <summary>
    /// Deletes the provided cart
    /// </summary>
    /// <param name="id">The cart ID to be removed</param>
    /// <response code="200">Cart was removed</response>
    /// <response code="404">The provided cart does not exist</response>
    [HttpDelete("{id}")]
    public IActionResult Delete(string id)
    {
        try
        {
            if (!_cartService.Delete(id))
            {
                return NotFound(id);
            }

            return Ok();
        }
        catch (NotFoundException)
        {
            return NotFound(id);
        }
    }

    /// <summary>
    /// Retrieves products of the specified cart
    /// </summary>
    /// <param name="cartId">The cart to be fetched</param>
    /// <returns>A set of products of the cart</returns>
    /// <response code="200">A list of products fetched</response>
    /// <response code="404">The provided cart does not exist</response>
    [HttpGet("{cartId}/products")]
    public async Task<IActionResult> GetProducts(string cartId)
    {
        try
        {
            CartDto cart = await _cartService.GetAsync(cartId);
            return Ok(cart.Products);
        }
        catch (NotFoundException)
        {
            return NotFound("The provided product does not exist: " + cartId);
        }
    }

    /// <summary>
    /// Adds a new product to the cart. If the cart does not exist, it will be created.
    /// </summary>
    /// <param name="cartId">The target cart</param>
    /// <param name="request">Product details to be added</param>
    /// <returns>Updated cart products</returns>
    /// <response code="200">A product was added</response>
    /// <response code="404">The provided cart does not exist</response>
    [HttpPost("{cartId}/products")]
    public async Task<IActionResult> AddProduct(string cartId, [FromBody] ModifyProductCountRequest request)
    {
        try
        {
            CartDto cart = await _cartService.AddProductAsync(cartId, request.ProductId, request.Count);
            return Ok(cart.Products);
        }
        catch (NotFoundException)
        {
            return NotFound("The provided product does not exist: " + request.ProductId);
        }
    }

    /// <summary>
    /// Removes a product from a cart
    /// </summary>
    /// <param name="cartId">The target cart</param>
    /// <param name="productId">The target product</param>
    /// <param name="count">Number of products to ve removed. Optional</param>
    /// <response code="204">Product was removed</response>
    /// <response code="404">The provided cart does not exist</response>
    [HttpDelete("{cartId}/products/{productId}")]
    public IActionResult RemoveProduct(string cartId, int productId, [FromQuery] int? count)
    {
        try
        {
            _cartService.DeleteProduct(cartId, productId, count);
            return NoContent();
        }
        catch (NotFoundException)
        {
            return NotFound(cartId);
        }
    }
}