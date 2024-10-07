
using CatalogService.Application.Categories.Queries.Common.Dto;
using CatalogService.Application.Categories.Queries.Common.Mappers;
using CatalogService.Application.Common.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace CatalogService.Application.Categories.Queries.GetCategories;

public class GetCategoriesHandler(IApplicationDbContext dbContext) : IRequestHandler<GetCategoriesQuery, IReadOnlyCollection<CategoryDto>>
{
    private readonly IApplicationDbContext _dbContext = dbContext;

    public async Task<IReadOnlyCollection<CategoryDto>> Handle(GetCategoriesQuery request, CancellationToken cancellationToken)
    {
        var categories = await _dbContext.Categories.Select(x => x.ToDto()).ToArrayAsync(cancellationToken);

        return categories;
    }
}
