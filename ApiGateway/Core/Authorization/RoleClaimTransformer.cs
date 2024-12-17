using Microsoft.AspNetCore.Authentication;

using System.Data;
using System.Security.Claims;
using System.Text.Json;

namespace ApiGateway.Core.Authorization;

public class RoleClaimTransformer : IClaimsTransformation
{
    public Task<ClaimsPrincipal> TransformAsync(ClaimsPrincipal principal)
    {
        var identity = principal.Identity as ClaimsIdentity;

        var realmAccess = identity?.FindFirst("realm_access")?.Value;
        if (identity != null && realmAccess != null)
        {
            var parsedRealmAccess = JsonDocument.Parse(realmAccess);

            if (parsedRealmAccess.RootElement.TryGetProperty("roles", out var jsonRoles))
            {
                var roles = jsonRoles.EnumerateArray().Select(r => r.GetString()).Where(x => x != null).Select(x => x!);
                foreach (var role in roles)
                {
                    identity.AddClaim(new Claim("role", role));
                }
            }
        }

        return Task.FromResult(principal);
    }
}
