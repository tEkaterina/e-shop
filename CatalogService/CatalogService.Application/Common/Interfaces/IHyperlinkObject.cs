using CatalogService.Application.Common.Models;

namespace CatalogService.Application.Common.Interfaces;

public interface IHyperlinkObject
{
    IReadOnlyCollection<HypermediaLink> Links { get; }
}
