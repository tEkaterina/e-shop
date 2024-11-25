using Ardalis.GuardClauses;

using CartService.DataAccess.Common.Entities;
using CartService.DataAccess.Repository.Cart;
using CartService.Services.Cart.Mappers;
using CartService.Services.Common.Dto;
using CartService.Services.Product;

using FluentAssertions;

using Moq;

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
        public void GetAsync_ThrowsNotFound_WhenCartDoesNotExist()
        {
            // arrange
            CartEntity? cart = null;
            _repositoryMock.Setup(x => x.GetCart("abc")).Returns(cart);

            // act
            Func<CartDto> getCart = () => _cartService.Get("abc");

            // assert
            getCart.Should().Throw<NotFoundException>();
        }

        [Fact]
        public void GetAsync_ReturnsCartDto_WhenCartExists()
        {
            // arrange
            CartEntity cart = new("abc");
            CartDto expectedResult = new("abc");
            _repositoryMock.Setup(x => x.GetCart("abc")).Returns(cart);
            _mapperMock.Setup(x => x.ToCartDto(cart)).Returns(expectedResult);

            // act
            CartDto? result = _cartService.Get("abc");

            // assert
            result.Should().Be(expectedResult);
        }
    }
}
