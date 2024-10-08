using CatalogService.Application.Common.Interfaces;
using CatalogService.Application.Products.Queries.Common.Dto;
using CatalogService.Application.Products.Queries.Common.Mappers;
using Microsoft.EntityFrameworkCore;

namespace CatalogService.Application.Products.Queries.GetProducts
{
    public class GetProductsHandler(IApplicationDbContext dbContext) : IRequestHandler<GetProductsQuery, IReadOnlyCollection<ProductDto>>
    {
        private readonly IApplicationDbContext _dbContext = dbContext;

        public async Task<IReadOnlyCollection<ProductDto>> Handle(GetProductsQuery request, CancellationToken cancellationToken)
        {
            IQueryable<Product> products = _dbContext.Products;

            if (request.CategoryId.HasValue)
            {
                products = products.Where(x => x.CategoryId == request.CategoryId);
            }

            return await products.Select(x => x.ToProductDto()).ToArrayAsync(cancellationToken);
        }
    }
}
