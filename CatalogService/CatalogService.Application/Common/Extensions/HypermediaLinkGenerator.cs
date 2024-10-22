using CatalogService.Application.Common.Interfaces;
using CatalogService.Application.Common.Models;

namespace CatalogService.Application.Common.Extensions;

public static class HypermediaLinkGenerator
{
    public static IReadOnlyCollection<HypermediaLink> GenerateAll(
        string id,
        string location
    )
    {
        return [
            new HypermediaLink("self", $"/{location}/{id}", "GET"),
            new HypermediaLink("update", $"/{location}/{id}", "PUT"),
            new HypermediaLink("remove", $"/{location}/{id}", "DELETE")
        ];
    }
}
