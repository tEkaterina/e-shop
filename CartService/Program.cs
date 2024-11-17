using CartService.DataAccess;
using CartService.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Versioning;
using CartService.WebApi;
using EShop.MessageBrokerClient;

public class Program
{
    public static async Task Main(string[] args)
    {
        var builder = WebApplication.CreateBuilder(args);

        // Add services to the container.

        builder.Services.AddControllers();
        builder.Services.AddDataAccessServices(builder.Configuration, builder.Environment);
        builder.Services.AddApplicationServices();

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
        await messageBroker.InitializeAsync();

        // Configure the HTTP request pipeline.

        app.AddSwagger();

        app.UseHttpsRedirection();

        app.UseAuthorization();

        app.MapControllers();

        app.Run();
    }
}
