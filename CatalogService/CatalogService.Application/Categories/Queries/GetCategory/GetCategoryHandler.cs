using CatalogService.Application.Categories.Queries.Common.Dto;
using CatalogService.Application.Categories.Queries.Common.Mappers;
using CatalogService.Application.Common.Interfaces;

namespace CatalogService.Application.Categories.Queries.GetCategory;

public class GetCategoryHandler(IApplicationDbContext dbContext) : IRequestHandler<GetCategoryQuery, CategoryDto>
{
    private readonly IApplicationDbContext _dbContext = dbContext;

    public async Task<CategoryDto> Handle(GetCategoryQuery request, CancellationToken cancellationToken)
    {
        var category = await _dbContext.Categories.FindAsync([request.Id], cancellationToken);

        Guard.Against.NotFound(request.Id, category);

        return category.ToDto();
    }
}
