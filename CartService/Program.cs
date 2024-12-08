using CartService.Configuration;
using CartService.DataAccess;
using CartService.Services;
using CartService.Services.Authorization;
using CartService.WebApi;

using EShop.MessageBrokerClient;

using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Versioning;

public class Program
{
    public static async Task Main(string[] args)
    {
        var builder = WebApplication.CreateBuilder(args);

        builder.Configuration.AddEnvironmentVariables(prefix: EnvConfiguration.AppEnvVariablePrefix);

        // Add services to the container.

        builder.Services.AddControllers();
        builder.Services.AddDataAccessServices(builder.Configuration);
        builder.Services.AddApplicationServices(builder.Configuration);

        builder.Services.AddApiVersioning(options =>
        {
            options.ReportApiVersions = true;
            options.DefaultApiVersion = new ApiVersion(1, 0);
            options.AssumeDefaultVersionWhenUnspecified = true;
            options.ApiVersionReader = new HeaderApiVersionReader("x-api-version");
        });

        builder.Services.AddOpenApiGeneration();

        var app = builder.Build();

        // Initialize
        var messageBroker = app.Services.GetRequiredService<IMessageBroker>();
        await messageBroker.InitializeAsync().ConfigureAwait(false);

        // Configure the HTTP request pipeline.

        app.AddSwagger();

        app.UseHttpsRedirection();

        app.UseAuthentication();
        app.UseAuthorization();

        app.MapControllers();

        app.UseMiddleware<LogUserMiddleware>();

        app.Run();
    }
}
