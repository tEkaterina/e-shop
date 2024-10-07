using CatalogService.Application.Common.Interfaces;

namespace CatalogService.Application.Categories.Commands.CreateCategory;

public class CreateCategoryHandler(IApplicationDbContext dbContext) : IRequestHandler<CreateCategoryCommand, int>
{
    private readonly IApplicationDbContext _dbContext = dbContext;

    public async Task<int> Handle(CreateCategoryCommand request, CancellationToken cancellationToken)
    {
        var category = new Category
        {
            Name = request.Name,
            Image = request.Image,
            ParentCategoryId = request.ParentCategoryId
        };

        _dbContext.Categories.Add(category);

        await _dbContext.SaveAsync(cancellationToken);

        return category.Id;
    }
}
