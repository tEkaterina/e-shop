using ApiGateway.Core;
using Ocelot.Middleware;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Configuration.AddGatewayConfig();
builder.Services.AddGatewayServices();

var app = builder.Build();

// Configure the HTTP request pipeline.

app.UseHttpsRedirection();

app.UseOcelot().Wait();

app.Run();
