using CatalogService.Infrastructure;
using CatalogService.Infrastructure.DataAccess;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace CatalogService.Application.IntegrationTests
{
    public class IntegrationTestFixture : IDisposable
    {
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

            ServiceProvider = services.BuildServiceProvider();

            RestoreDb();
        }

        public async Task<T> ExecuteCommand<T>(IRequest<T> command)
        {
            using var scope = ServiceProvider.CreateScope();
            var mediatr = scope.ServiceProvider.GetRequiredService<ISender>();

            return await mediatr.Send(command);
        }


        public void Dispose()
        {
            using var scope = ServiceProvider.CreateScope();

            var context = scope.ServiceProvider.GetRequiredService<ApplicationDbContext>();
            context.Database.CloseConnection();
        }

        private void RestoreDb()
        {
            var scope = ServiceProvider.CreateScope();

            var context = scope.ServiceProvider.GetRequiredService<ApplicationDbContext>();
            context.Database.OpenConnection();
            context.Database.EnsureCreated();
            context.Database.Migrate();

        }
    }
}
