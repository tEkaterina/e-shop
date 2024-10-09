using CatalogService.Application.Common.Interfaces;

namespace CatalogService.Application.Categories.Commands.UpdateCategory;

public class UpdateCategoryHandler(IApplicationDbContext dbContext) : IRequestHandler<UpdateCategoryCommand>
{
    private readonly IApplicationDbContext _dbContext = dbContext;

    public async Task Handle(UpdateCategoryCommand request, CancellationToken cancellationToken)
    {
        var category = await _dbContext.Categories.FindAsync([request.Id], cancellationToken);

        Guard.Against.NotFound(request.Id, category);

        category.Image = request.Image;
        category.Name = request.Name;
        category.ParentCategoryId = request.ParentCategoryId;

        await _dbContext.SaveChangesAsync(cancellationToken);
    }
}
