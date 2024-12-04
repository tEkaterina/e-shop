using System.Security.Claims;
using System.Text.Json;

using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;

namespace CatalogService.Infrastructure.Authorization;

public static class DependencyInjection
{
    public static IServiceCollection AddAuthorizationServices(this IServiceCollection services, IConfiguration configuration)
    {
        var config = configuration.GetSection("JwtTokenConfig").Get<JwtTokenConfig>()
            ?? throw new ApplicationException("Invalid JWT token configuration");

        services.AddAuthorization(options =>
        {
            options.AddPolicy("Manager", policy => policy.RequireRole("eshop_manager"));

            options.AddPolicy("AuthenticatedUser", policy => policy.RequireAuthenticatedUser());

        }).AddAuthentication(JwtBearerDefaults.AuthenticationScheme).AddJwtBearer(options =>
        {
            options.Authority = config.Authority;
            options.Audience = config.Issuer;
            options.RequireHttpsMetadata = false;

            options.TokenValidationParameters = new TokenValidationParameters
            {
                ValidateIssuer = false,
                ValidateAudience = false,
                ValidateLifetime = true,
                RoleClaimType = ClaimTypes.Role
            };

            options.Events = new JwtBearerEvents
            {
                OnTokenValidated = ctx =>
                {
                    var realmAccess = ctx.Principal?.FindFirst("realm_access")?.Value;

                    if (realmAccess != null)
                    {
                        var parsedRealmAccess = JsonDocument.Parse(realmAccess);
                        if (parsedRealmAccess.RootElement.TryGetProperty("roles", out var roles))
                        {
                            var claims = roles.EnumerateArray().Select(r => new Claim(ClaimTypes.Role, r.GetString()));
                            var appIdentity = new ClaimsIdentity(claims);
                            ctx.Principal?.AddIdentity(appIdentity);
                        }
                    }
                    return Task.CompletedTask;
                }
            };
        });

        return services;
    }
}
