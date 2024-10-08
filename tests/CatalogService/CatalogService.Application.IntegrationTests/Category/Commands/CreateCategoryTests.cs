using CatalogService.Application.Categories.Commands.CreateCategory;
using FluentAssertions;

namespace CatalogService.Application.IntegrationTests.Category.Commands
{
    public class CreateCategoryTests(IntegrationTestFixture fixture) : IClassFixture<IntegrationTestFixture>
    {
        private readonly IntegrationTestFixture _fixture = fixture;

        [Fact]
        public async Task CreateCategory_CreatesNewCategory()
        {
            // arrange
            var createCategoryCommand = new CreateCategoryCommand
            {
                Name = "test_category"
            };

            // act
            var newId = await _fixture.ExecuteCommand(createCategoryCommand);

            // assert
            newId.Should().BeGreaterThan(0);
        }
    }
}
