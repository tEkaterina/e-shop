using CatalogService.Infrastructure;
using CatalogService.Infrastructure.Authorization;
using CatalogService.Infrastructure.DataAccess;
using CatalogService.Infrastructure.Environment;

using EShop.MessageBrokerClient;

namespace CatalogService.Web;

public class Program
{
    public static async Task Main(string[] args)
    {
        var builder = WebApplication.CreateBuilder(args);

        builder.Configuration.AddEnvironmentVariables(prefix: EnvConfiguration.AppEnvVariablePrefix);

        // Add services to the container.
        builder.Services.AddInfrastructureServices(builder.Configuration);
        builder.Services.AddAppServices();
        builder.Services.AddControllers();
        builder.Services.AddAuthorizationServices(builder.Configuration);

        builder.Services.AddEndpointsApiExplorer();
        builder.Services.AddSwaggerGen();

        var app = builder.Build();

        // Initialize
        var messageBroker = app.Services.GetRequiredService<IMessageBroker>();
        await messageBroker.InitializeAsync().ConfigureAwait(false);

        // Configure the HTTP request pipeline.

        app.UseAuthentication();
        app.UseAuthorization();

        app.MapControllers();

        using (var scope = app.Services.CreateScope())
        {
            var dbInitializer = scope.ServiceProvider.GetRequiredService<IDbInitializer>();
            await dbInitializer.InitializeAsync().ConfigureAwait(false);
        }

        app.UseSwagger();
        app.UseSwaggerUI();

        app.Run();
    }
}
