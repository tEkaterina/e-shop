using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using System.Security.Claims;

namespace ApiGateway.Core.Authorization;

public static class DependencyInjection
{
    public static IServiceCollection AddAuthorizationServices(this IServiceCollection services, IConfiguration configuration)
    {
        var config = configuration.GetSection("JwtTokenConfig").Get<JwtTokenConfig>()
            ?? throw new ApplicationException("Invalid JWT token configuration");

        services.AddAuthorization().AddAuthentication(JwtBearerDefaults.AuthenticationScheme).AddJwtBearer(options =>
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
        });

        services.AddTransient<IClaimsTransformation, RoleClaimTransformer>();

        return services;
    }
}
