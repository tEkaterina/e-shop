using System.Net.Http.Json;
using FluentAssertions;

namespace CatalogService.Web.IntegrationTests;

public class CategoriesApiTest(CatalogServiceWebAppFactory factory) : IClassFixture<CatalogServiceWebAppFactory>
{
    private readonly HttpClient _client = factory.CreateClient();

    [Fact]
    public async Task CategoriesEndpoint_AddsNewCategory()
    {
        // Arrange
        var url = "/api/categories";

        // Act
        var response = await _client.PostAsJsonAsync(url, new { Name = "Category1" });

        // Assert
        response.EnsureSuccessStatusCode();
        var products = await response.Content.ReadFromJsonAsync<int>();
        products.Should().BeGreaterThan(0);
    }
}