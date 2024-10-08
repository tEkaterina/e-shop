using CatalogService.Application.Products.Queries.Common.Dto;

namespace CatalogService.Application.Products.Queries.GetProduct;

public record GetProductQuery(int Id) : IRequest<ProductDto>;
