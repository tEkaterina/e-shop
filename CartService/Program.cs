using CartService.DataAccess.Extentions;
using CartService.Services.Extentions;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
builder.Services.AddDataAccessServices(builder.Configuration);
builder.Services.AddApplicationServices();

var app = builder.Build();

// Configure the HTTP request pipeline.

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
