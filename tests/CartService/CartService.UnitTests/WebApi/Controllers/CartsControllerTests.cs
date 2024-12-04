
using Ardalis.GuardClauses;

using CartService.Services.Cart;
using CartService.Services.Common.Dto;
using CartService.Services.Product;
using CartService.WebApi.Controllers;

using FluentAssertions;

using Microsoft.AspNetCore.Mvc;

using Moq;

namespace CartService.UnitTests.WebApi.Controllers;

public class CartsControllerTests
{
    private readonly Mock<ICartService> _cartServiceMock;
    private readonly Mock<IProductService> _productServiceMock;
    private readonly CartsController _controller;

    public CartsControllerTests()
    {
        _cartServiceMock = new Mock<ICartService>();
        _productServiceMock = new Mock<IProductService>();
        _controller = new CartsController(_cartServiceMock.Object, _productServiceMock.Object);
    }

    [Fact]
    public void GetProducts_ReturnsOk_WithProductList()
    {
        // arrange
        ProductDto[] products = [new ProductDto(10, "Product1")];
        CartDto cartDto = new("abc") { Products = products };

        _cartServiceMock.Setup(x => x.Get("abc")).Returns(cartDto);

        // act
        IActionResult result = _controller.GetProducts("abc");

        // assert
        OkObjectResult okResult = result.Should().BeOfType<OkObjectResult>().Subject;
        okResult.Value.Should().BeEquivalentTo(products);
    }

    [Fact]
    public void GetProducts_ReturnsNotFound_WhenCartDoesNotExist()
    {
        // arrange
        _cartServiceMock.Setup(x => x.Get("abc")).Throws(new NotFoundException("cartId", "cart"));

        // act
        IActionResult result = _controller.GetProducts("abc");

        // assert
        result.Should().BeOfType<NotFoundObjectResult>();
    }
}
