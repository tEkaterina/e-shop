using Ardalis.GuardClauses;

using CatalogService.Application.Categories.Commands.DeleteCategory;
using CatalogService.Application.Common.Interfaces;

using Microsoft.EntityFrameworkCore;

namespace CatalogService.Application.UnitTests.Category.Commands;

public class DeleteCategoryTests
{
    [Fact]
    public async Task Handle_DeletesCategory_WhenCategoryExists()
    {
        // Arrange
        var categoryId = 1;
        var category = new Domain.Entities.Category { Id = categoryId };

        var mockDbSet = new Mock<DbSet<Domain.Entities.Category>>();
        mockDbSet.Setup(m => m.FindAsync(new object[] { categoryId }, It.IsAny<CancellationToken>()))
            .ReturnsAsync(category);

        var mockDbContext = new Mock<IApplicationDbContext>();
        mockDbContext.Setup(m => m.Categories).Returns(mockDbSet.Object);
        mockDbContext.Setup(m => m.SaveChangesAsync(It.IsAny<CancellationToken>())).ReturnsAsync(1);

        var handler = new DeleteCategoryHandler(mockDbContext.Object);
        var command = new DeleteCategoryCommand(categoryId);

        // Act
        await handler.Handle(command, CancellationToken.None).ConfigureAwait(true);

        // Assert
        mockDbSet.Verify(m => m.Remove(It.Is<Domain.Entities.Category>(c => c.Id == categoryId)), Times.Once);
        mockDbContext.Verify(m => m.SaveChangesAsync(It.IsAny<CancellationToken>()), Times.Once);
    }

    [Fact]
    public async Task Handle_ThrowsNotFoundException_WhenCategoryDoesNotExist()
    {
        // Arrange
        var categoryId = 1;

        var mockDbSet = new Mock<DbSet<Domain.Entities.Category>>();
        mockDbSet.Setup(m => m.FindAsync(new object[] { categoryId }, It.IsAny<CancellationToken>()))
            .ReturnsAsync(null as Domain.Entities.Category);

        var mockDbContext = new Mock<IApplicationDbContext>();
        mockDbContext.Setup(m => m.Categories).Returns(mockDbSet.Object);

        var handler = new DeleteCategoryHandler(mockDbContext.Object);
        var command = new DeleteCategoryCommand(categoryId);

        // Act
        Func<Task> act = async () => { await handler.Handle(command, CancellationToken.None).ConfigureAwait(false); };

        // Assert
        await act.Should().ThrowAsync<NotFoundException>().ConfigureAwait(true);
    }
}
