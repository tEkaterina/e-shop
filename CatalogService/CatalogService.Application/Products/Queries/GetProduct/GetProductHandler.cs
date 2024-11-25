using CatalogService.Application.Common.Interfaces;
using CatalogService.Application.Products.Queries.Common.Dto;
using CatalogService.Application.Products.Queries.Common.Mappers;

namespace CatalogService.Application.Products.Queries.GetProduct;

public class GetProductHandler(IApplicationDbContext dbContext) : IRequestHandler<GetProductQuery, ProductDto>
{
    private readonly IApplicationDbContext _dbContext = dbContext;

    public async Task<ProductDto> Handle(GetProductQuery request, CancellationToken cancellationToken)
    {
        var product = await _dbContext.Products.FindAsync([request.Id], cancellationToken).ConfigureAwait(false);

        Guard.Against.NotFound(request.Id, product);

        return product.ToProductDto();
    }
}
