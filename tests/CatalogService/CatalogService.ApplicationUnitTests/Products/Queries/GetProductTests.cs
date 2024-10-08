using Ardalis.GuardClauses;
using CatalogService.Application.Common.Interfaces;
using CatalogService.Application.Products.Queries.Common.Dto;
using CatalogService.Application.Products.Queries.GetProduct;
using Microsoft.EntityFrameworkCore;

namespace CatalogService.Application.UnitTests.Products.Queries
{
    public class GetProductTests
    {
        [Fact]
        public async Task Handle_ReturnsProductDto_WhenProductExists()
        {
            // Arrange
            var productId = 1;
            var product = new Product { Id = productId, Name = "Test Product", Price = 99.99M, Amount = 100, CategoryId = 56 };
            var productDto = new ProductDto(productId, "Test Product", 99.99M, 100, 56);

            var mockDbSet = new Mock<DbSet<Product>>();
            mockDbSet.Setup(m => m.FindAsync(new object[] { productId }, It.IsAny<CancellationToken>()))
                .ReturnsAsync(product);

            var mockDbContext = new Mock<IApplicationDbContext>();
            mockDbContext.Setup(m => m.Products).Returns(mockDbSet.Object);

            var handler = new GetProductHandler(mockDbContext.Object);
            var query = new GetProductQuery(productId);

            // Act
            var result = await handler.Handle(query, CancellationToken.None);

            // Assert
            result.Should().BeEquivalentTo(productDto);
        }

        [Fact]
        public async Task Handle_ShouldThrowNotFoundException_WhenProductDoesNotExist()
        {
            // Arrange
            var productId = 1;

            var mockDbSet = new Mock<DbSet<Product>>();
            mockDbSet.Setup(m => m.FindAsync(new object[] { productId }, It.IsAny<CancellationToken>()))
                .ReturnsAsync(null as Product);

            var mockDbContext = new Mock<IApplicationDbContext>();
            mockDbContext.Setup(m => m.Products).Returns(mockDbSet.Object);

            var handler = new GetProductHandler(mockDbContext.Object);
            var query = new GetProductQuery(productId);

            // Act
            Func<Task> act = async () => { await handler.Handle(query, CancellationToken.None); };

            // Assert
            await act.Should().ThrowAsync<NotFoundException>();
        }
    }
}
