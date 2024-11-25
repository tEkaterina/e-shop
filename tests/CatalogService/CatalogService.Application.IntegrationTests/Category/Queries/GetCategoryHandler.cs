using Ardalis.GuardClauses;

using CatalogService.Application.Categories.Commands.CreateCategory;
using CatalogService.Application.Categories.Queries.GetCategory;

using FluentAssertions;

namespace CatalogService.Application.IntegrationTests.Category.Queries;

public class GetCategoryHandler(IntegrationTestFixture _fixture) : IClassFixture<IntegrationTestFixture>
{
    [Fact]
    public async Task GetCategory_ReturnsCategoryDto_WhenCategoryExists()
    {
        // Arrange
        var createCategoryCommand = new CreateCategoryCommand
        {
            Name = "test_category"
        };

        var newId = await _fixture.ExecuteCommand(createCategoryCommand).ConfigureAwait(true);

        var getCategoryQuery = new GetCategoryQuery(newId);

        // Act
        var categoryDto = await _fixture.ExecuteCommand(getCategoryQuery).ConfigureAwait(true);

        // Assert
        categoryDto.Should().NotBeNull();
        categoryDto.Id.Should().Be(newId);
        categoryDto.Name.Should().Be("test_category");
    }

    [Fact]
    public async Task GetCategory_ThrowsNotFoundException_WhenCategoryDoesNotExist()
    {
        // Arrange
        var getCategoryQuery = new GetCategoryQuery(999);

        // Act
        Func<Task> act = async () => await _fixture.ExecuteCommand(getCategoryQuery).ConfigureAwait(true);

        // Assert
        await act.Should().ThrowAsync<NotFoundException>().ConfigureAwait(true);
    }
}
