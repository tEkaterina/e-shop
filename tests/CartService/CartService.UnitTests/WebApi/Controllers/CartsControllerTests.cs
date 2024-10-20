
using Moq;
using CartService.WebApi.Controllers;
using CartService.Services.Cart;
using CartService.Services.Common.Dto;
using Microsoft.AspNetCore.Mvc;
using FluentAssertions;

namespace CartService.UnitTests.WebApi.Controllers;

public class CartsControllerTests
{
    private readonly Mock<ICartService> _cartServiceMock;
    private readonly CartsController _controller;

    public CartsControllerTests()
    {
        _cartServiceMock = new Mock<ICartService>();
        _controller = new CartsController(_cartServiceMock.Object);
    }

    [Fact]
    public async Task GetProducts_ReturnsOk_WithProductList()
    {
        // arrange
        ProductDto[] products = [new ProductDto(10, "Product1")];
        CartDto cartDto = new() { Products = products };

        _cartServiceMock.Setup(x => x.GetAsync("abc")).ReturnsAsync(cartDto);

        // act
        IActionResult result = await _controller.GetProducts("abc");

        // assert
        OkObjectResult okResult = result.Should().BeOfType<OkObjectResult>().Subject;
        okResult.Value.Should().BeEquivalentTo(products);
    }

    [Fact]
    public async Task GetProducts_ReturnsNotFound_WhenCartDoesNotExist()
    {
        // arrange
        CartDto? cartDto = null;
        _cartServiceMock.Setup(x => x.GetAsync("abc")).ReturnsAsync(cartDto);

        // act
        IActionResult result = await _controller.GetProducts("abc");

        // assert
        result.Should().BeOfType<NotFoundObjectResult>();
    }
}
