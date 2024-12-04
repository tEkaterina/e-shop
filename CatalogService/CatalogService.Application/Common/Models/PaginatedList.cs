using System;

using Microsoft.EntityFrameworkCore;

namespace CatalogService.Application.Common.Models;

public class PaginatedList<T>
{
    public IReadOnlyCollection<T> Items { get; }
    public int PageIndex { get; }
    public int PageSize { get; }
    public int TotalPages { get; }
    public int TotalCount { get; }

    private PaginatedList(IReadOnlyCollection<T> items, int index, int totalPages, int totalCount, int pageSize)
    {
        Items = items;
        PageIndex = index;
        PageSize = pageSize;
        TotalPages = totalPages;
        TotalCount = totalCount;
    }

    public static async Task<PaginatedList<T>> CreateAsync(IQueryable<T> source, int pageIndex, int pageSize, CancellationToken cancellationToken)
    {
        var count = await source.CountAsync(cancellationToken).ConfigureAwait(false);
        var totalPages = ( int )Math.Ceiling(count / ( double )pageIndex);

        var items = await source.Skip((pageIndex - 1) * pageSize).Take(pageSize).ToListAsync(cancellationToken).ConfigureAwait(false);

        return new PaginatedList<T>(items, pageIndex, totalPages, count, pageSize);
    }
}
