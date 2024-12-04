using CatalogService.Infrastructure;
using CatalogService.Infrastructure.DataAccess;

using MediatR;

using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace CatalogService.Application.IntegrationTests;

public class IntegrationTestFixture : IDisposable
{
    private readonly IServiceScope _serviceScope;
    public IServiceProvider ServiceProvider { get; init; }

    public IntegrationTestFixture()
    {
        var services = new ServiceCollection();

        Dictionary<string, string?>? inMemorySettings = new()
        {
            {"ConnectionStrings:DefaultConnection", "DataSource=:memory:"}
        };

        var configuration = new ConfigurationBuilder()
            .AddInMemoryCollection(inMemorySettings)
            .Build();

        services.AddAppServices();
        services.AddInfrastructureServices(configuration);

        _serviceScope = services.BuildServiceProvider().CreateScope();
        ServiceProvider = _serviceScope.ServiceProvider;

        RestoreDataBase();
    }

    public async Task<T> ExecuteCommand<T>(IRequest<T> command)
    {
        var mediatr = ServiceProvider.GetRequiredService<ISender>();

        return await mediatr.Send(command).ConfigureAwait(false);
    }


    public void Dispose()
    {
        var context = ServiceProvider.GetRequiredService<ApplicationDbContext>();
        context.Database.CloseConnection();
        _serviceScope.Dispose();
    }

    private void RestoreDataBase()
    {
        var context = ServiceProvider.GetRequiredService<ApplicationDbContext>();
        context.Database.OpenConnection();
        context.Database.EnsureCreated();
    }
}
