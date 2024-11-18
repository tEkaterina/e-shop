﻿using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using System.Security.Claims;
using System.Text.Json;

namespace CartService.Services.Authorization;

public static class DependencyInjection
{
    public static IServiceCollection AddAuthorizationServices(this IServiceCollection services, IConfiguration configuration)
    {
        var config = configuration.GetSection("JwtTokenConfig").Get<JwtTokenConfig>()
            ?? throw new ApplicationException("Invalid JWT token configuration");

        services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme).AddJwtBearer(options =>
        {
            options.Authority = config.Authority;
            options.Audience = config.Issuer;
            options.RequireHttpsMetadata = false;

            options.TokenValidationParameters = new TokenValidationParameters
            {
                ValidateIssuer = false,
                ValidateAudience = false,
                ValidateLifetime = true,
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

        services.AddTransient<LogUserMiddleware>();

        return services;
    }
}