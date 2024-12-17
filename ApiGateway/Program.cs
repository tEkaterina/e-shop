using ApiGateway.Core;
using ApiGateway.Core.Authorization;

using Ocelot.Middleware;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Configuration.AddEnvironmentVariables(prefix: EnvConfiguration.AppEnvVariablePrefix);
builder.Configuration.AddGatewayConfig();
builder.Services.AddGatewayServices();
builder.Services.AddAuthorizationServices(builder.Configuration);

var app = builder.Build();

// Configure the HTTP request pipeline.

app.UseHttpsRedirection();

app.UseAuthentication();
app.UseAuthorization();

app.UseOcelot().Wait();

app.Run();
