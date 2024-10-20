using CatalogService.Application.Products.Queries.Common.Dto;

namespace CatalogService.Application.Products.Queries.GetProducts;

public record GetProductsQuery : IRequest<IReadOnlyCollection<ProductDto>>
{
    public int? CategoryId { get; init; }
}
