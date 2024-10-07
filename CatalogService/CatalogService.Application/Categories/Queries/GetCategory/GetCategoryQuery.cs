using CatalogService.Application.Categories.Queries.Common.Dto;

namespace CatalogService.Application.Categories.Queries.GetCategory;

public record GetCategoryQuery(int Id): IRequest<CategoryDto>;
