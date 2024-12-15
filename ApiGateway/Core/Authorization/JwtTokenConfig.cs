namespace ApiGateway.Core.Authorization;

internal class JwtTokenConfig
{
    public required string Authority { get; init; }
    public required string Issuer { get; init; }
}
