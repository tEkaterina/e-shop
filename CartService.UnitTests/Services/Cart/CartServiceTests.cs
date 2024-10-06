using CartService.DataAccess.Entities;
using CartService.DataAccess.Repository;
using CartService.Services.Cart;
using CartService.Services.Dto;
using CartService.Services.Mappers;
using CartService.Services.Product;
using FluentAssertions;
using Moq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CartService.UnitTests.Services.Cart
{
    public class CartServiceTests
    {
        private readonly Mock<ICartMapper> _mapperMock = new();
        private readonly Mock<IProductService> _productServiceMock = new();
        private readonly Mock<ICartRepository> _repositoryMock = new();

        private readonly CartService.Services.Cart.CartService _cartService;

        public CartServiceTests()
        {
            _cartService = new CartService.Services.Cart.CartService(_mapperMock.Object, _repositoryMock.Object, _productServiceMock.Object);
        }

        [Fact]
        public async Task GetAsync_ReturnsNull_WhenCartDoesNotExist()
        {
            // arrange
            CartEntity? cart = null;
            _repositoryMock.Setup(x => x.GetCart("abc")).Returns(cart);

            // act
            CartDto? result = await _cartService.GetAsync("abc");
            
            // assert
            result.Should().BeNull();
        }

        [Fact]
        public async Task GetAsync_ReturnsCartDto_WhenCartExists()
        {
            // arrange
            CartEntity cart = new();
            CartDto expectedResult = new();
            _repositoryMock.Setup(x => x.GetCart("abc")).Returns(cart);
            _mapperMock.Setup(x => x.ToCartDtoAsync(cart)).ReturnsAsync(expectedResult);

            // act
            CartDto? result = await _cartService.GetAsync("abc");

            // assert
            result.Should().Be(expectedResult);
        }
    }
}
