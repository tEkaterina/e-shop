using CatalogService.Application.Common.Interfaces;
using CatalogService.Application.Common.Models;
using CatalogService.Application.Products.Queries.Common.Dto;
using CatalogService.Application.Products.Queries.Common.Mappers;

namespace CatalogService.Application.Products.Queries.GetProducts
{
    public class GetProductsHandler(IApplicationDbContext dbContext) : IRequestHandler<GetProductsQuery, PaginatedList<ProductDto>>
    {
        private readonly IApplicationDbContext _dbContext = dbContext;

        public Task<PaginatedList<ProductDto>> Handle(GetProductsQuery request, CancellationToken cancellationToken)
        {
            IQueryable<Product> products = _dbContext.Products;

            if (request.CategoryId.HasValue)
            {
                products = products.Where(x => x.CategoryId == request.CategoryId);
            }

            return PaginatedList<ProductDto>.CreateAsync(products.Select(x => x.ToProductDto()), request.PageIndex, request.PageSize, cancellationToken);
        }
    }
}
