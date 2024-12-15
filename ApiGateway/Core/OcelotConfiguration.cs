namespace ApiGateway.Core;

public static class OcelotConfiguration
{
    public const string ConfigName = "ocelot.json";

    public static IReadOnlyDictionary<string, IReadOnlyDictionary<string, string>> ServiceRouteMap =
        new Dictionary<string, IReadOnlyDictionary<string, string>>
        {
            { 
                "CatalogService.Web", new Dictionary<string, string>
                {
                    { "/catalog", "/api" }
                }
            },
            {
                "CartService", new Dictionary<string, string>
                {
                    { "/carts", "/api/carts" }
                }
            }
        };
}
