using CatalogService.Application.Categories.Queries.Common.Dto;

namespace CatalogService.Application.Categories.Queries.Common.Mappers
{
    internal static class CategoryDtoMapper
    {
        internal static Category ToCategory(this CategoryDto dto)
        {
            return new Category()
            {
                Id = dto.Id,
                Name = dto.Name,
                Image = dto.Image,
                ParentCategoryId = dto.ParentCategoryId,
            };
        }

        internal static CategoryDto ToDto(this Category category)
        {
            return new CategoryDto(category.Id, category.Name, category.Image, category.ParentCategoryId);
        }
    }
}
