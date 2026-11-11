using System.Text.Json;
using System.Text.Json.Serialization;
using ShopEasy.API.Repositories;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers()
    .AddJsonOptions(options =>
    {
        options.JsonSerializerOptions.PropertyNamingPolicy = JsonNamingPolicy.CamelCase;
        options.JsonSerializerOptions.DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull;
        options.JsonSerializerOptions.Converters.Add(new JsonStringEnumConverter());
    });

// Dependency Injection: Direct Repository Pattern
builder.Services.AddSingleton<IProductRepository, ProductRepository>();
builder.Services.AddSingleton<IOrderRepository, OrderRepository>();

// Configure CORS for Flutter Web, mobile emulators, and local development
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", policy =>
    {
        policy.AllowAnyOrigin()
              .AllowAnyHeader()
              .AllowAnyMethod();
    });
});

// Swagger/OpenAPI
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new()
    {
        Title = "ShopEasy API",
        Version = "v1",
        Description = "ASP.NET Core Web API backend for the ShopEasy Flutter e-commerce application."
    });
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment() || true)
{
    app.UseSwagger();
    app.UseSwaggerUI(c =>
    {
        c.SwaggerEndpoint("/swagger/v1/swagger.json", "ShopEasy API v1");
        c.RoutePrefix = string.Empty; // Serve Swagger UI at app root
    });
}

app.UseCors("AllowAll");

// Note: Avoid enforcing HTTPS redirection in local dev to allow plain HTTP calls from Android emulator & web
// app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
