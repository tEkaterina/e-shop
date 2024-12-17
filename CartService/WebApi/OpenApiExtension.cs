using Microsoft.AspNetCore.Mvc;

namespace CartService.WebApi;

public static class OpenApiExtension
{
    private const string ServiceName = "CartService";

    public static void AddOpenApiGeneration(this IServiceCollection services)
    {
        services.AddVersionedApiExplorer(options =>
        {
            options.DefaultApiVersion = new ApiVersion(1, 0);
            options.GroupNameFormat = "'v'VVV";
            options.AssumeDefaultVersionWhenUnspecified = true;
        });

        Version[] versions = [new Version(2, 0), new Version(1, 0)];

        foreach (var version in versions)
        {
            services.AddOpenApiDocument(options =>
            {
                options.Title = ServiceName;
                options.DocumentName = "v" + version.Major;
                options.ApiGroupNames = ["v" + version.Major];
                options.Version = version.Major + "." + version.Minor;
            });
        }
    }

    public static void AddSwagger(this IApplicationBuilder app)
    {
        app.UseOpenApi();
        app.UseSwaggerUi();
    }
}
