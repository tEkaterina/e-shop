using CatalogService.Application.Common.Models;
using CatalogService.Application.Products.Queries.Common.Dto;

namespace CatalogService.Application.Products.Queries.GetProducts;

public record GetProductsQuery(int? CategoryId = null, int PageIndex = 1, int PageSize = 10) : IRequest<PaginatedList<ProductDto>>;
