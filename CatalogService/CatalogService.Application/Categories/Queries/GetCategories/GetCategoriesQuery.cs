using CatalogService.Application.Categories.Queries.Common.Dto;

namespace CatalogService.Application.Categories.Queries.GetCategories;

public record GetCategoriesQuery : IRequest<IReadOnlyCollection<CategoryDto>>;
