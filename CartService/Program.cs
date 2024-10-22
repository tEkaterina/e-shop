using CartService.DataAccess;
using CartService.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Versioning;

public class Program
{
    public static void Main(string[] args)
    {
        var builder = WebApplication.CreateBuilder(args);

        // Add services to the container.

        builder.Services.AddControllers();
        builder.Services.AddDataAccessServices(builder.Configuration);
        builder.Services.AddApplicationServices();

        builder.Services.AddApiVersioning(options => {
            options.ReportApiVersions = true;
            options.DefaultApiVersion = new ApiVersion(1, 0);
            options.AssumeDefaultVersionWhenUnspecified = true;
            options.ApiVersionReader = new HeaderApiVersionReader("x-api-version");
        });

        var app = builder.Build();

        // Configure the HTTP request pipeline.

        app.UseHttpsRedirection();

        app.UseAuthorization();

        app.MapControllers();

        app.Run();

    }
}
