using System;

namespace CatalogService.Infrastructure.DataAccess;

public interface IDbInitializer
{
    Task InitializeAsync();
}
