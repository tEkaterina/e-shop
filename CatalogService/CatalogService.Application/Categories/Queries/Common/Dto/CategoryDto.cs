namespace CatalogService.Application.Categories.Queries.Common.Dto;

public record CategoryDto(int Id, string Name, string? Image, int? ParentCategoryId);
