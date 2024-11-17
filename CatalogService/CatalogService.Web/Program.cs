using CatalogService.Infrastructure;
using CatalogService.Infrastructure.DataAccess;
using EShop.MessageBrokerClient;

namespace CatalogService.Web;

public class Program
{
    public static async Task Main(string[] args)
    {
        var builder = WebApplication.CreateBuilder(args);

        // Add services to the container.
        builder.Services.AddAppServices();
        builder.Services.AddInfrastructureServices(builder.Configuration);
        builder.Services.AddControllers();

        var app = builder.Build();

        // Initialize
        var messageBroker = app.Services.GetRequiredService<IMessageBroker>();
        await messageBroker.InitializeAsync();

        // Configure the HTTP request pipeline.

        app.UseHttpsRedirection();

        app.UseAuthorization();

        app.MapControllers();

        using (var scope = app.Services.CreateScope())
        {
            var dbInitializer = scope.ServiceProvider.GetRequiredService<IDbInitializer>();
            await dbInitializer.InitializeAsync();
        }

        app.Run();
    }
}
