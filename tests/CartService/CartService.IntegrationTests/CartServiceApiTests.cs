using CartService.Services.Common.Dto;
using FluentAssertions;
using System.Net.Http.Json;

namespace CartService.IntegrationTests
{
    public class CartServiceApiTests(CartServiceWebAppFactory factory) : IClassFixture<CartServiceWebAppFactory>
    {
        private readonly HttpClient _client = factory.CreateClient();

        [Fact]
        public async Task ProductsEndpoint_AddsNewProducts_WhenCartDoesNotExist()
        {
            // Arrange
            var url = "/api/carts/9876abcd-4321/products";

            // Act
            var response = await _client.PostAsJsonAsync(url, new { Id = 20, Name = "Product #20", Price = 200, Count = 2 });

            // Assert
            response.EnsureSuccessStatusCode();
            var products = await response.Content.ReadFromJsonAsync<ProductDto[]>();
            products.Should().Contain(new ProductDto(20, "Product #20") { Count = 2, Price = 200 });
        }
    }
}
