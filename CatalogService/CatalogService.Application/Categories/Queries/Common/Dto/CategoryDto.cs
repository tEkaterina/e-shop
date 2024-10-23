using CatalogService.Application.Common.Extensions;
using CatalogService.Application.Common.Interfaces;
using CatalogService.Application.Common.Models;

namespace CatalogService.Application.Categories.Queries.Common.Dto;

public record CategoryDto(int Id, string Name, string? Image, int? ParentCategoryId) : IHyperlinkObject
{
    public IReadOnlyCollection<HypermediaLink> Links { get; init; } = HypermediaLinkGenerator.GenerateAll(Id.ToString(), "categories");
}
