using Ocelot.Middleware;
using System.Net;

using Ocelot.Multiplexer;
using System.Text.Json;
using ApiGateway.Core;

namespace ApiGateway.Aggregators;

public class SwaggerAggregator : IDefinedAggregator
{
    public async Task<DownstreamResponse> Aggregate(List<HttpContext> responseContexts)
    {
        var responses = responseContexts.Select(x => x.Items.DownstreamResponse());
        var swaggerContents = await Task
            .WhenAll(responses.Select(x => x.Content.ReadAsStringAsync()))
            .ConfigureAwait(ConfigureAwaitOptions.None);

        if (swaggerContents == null)
        {
            throw new ApplicationException("Failed to fetch swagger files.");
        }

        JsonElement[] parsedSwaggerApis = swaggerContents
            .Select(x => JsonDocument.Parse(x))
            .Where(x => x != null)
            .Select(x => x.RootElement)
            .ToArray();

        var serializedResult = JsonSerializer.Serialize(MergeSwaggerFiles(parsedSwaggerApis));

        return new DownstreamResponse(
            new StringContent(serializedResult),
            HttpStatusCode.OK,
            responses.SelectMany(x => x.Headers).ToList(),
            "OK"
        );
    }

    private IReadOnlyDictionary<string, object> MergeSwaggerFiles(IEnumerable<JsonElement> parsedSwaggerApis)
    {
        var mergedPaths = JoinPaths(parsedSwaggerApis);
        var mergedComponents = JoinComponents(parsedSwaggerApis);

        var mergedSwaggerContent = new Dictionary<string, object>
        {
            { "openapi", "3.0.0" },
            {
                "info",
                new Dictionary<string, string>
                {
                    {"title", "E-Shop API"},
                    { "version", "1.0" }
                }
            },
            { "paths", mergedPaths },
            { "components", mergedComponents }
        };

        return mergedSwaggerContent;
    }

    private IReadOnlyDictionary<string, object> JoinComponents(IEnumerable<JsonElement> sources)
    {
        var joinedSchemas = new Dictionary<string, JsonElement>();
        foreach (var source in sources)
        {
            if (source.TryGetProperty("components", out JsonElement component))
            {
                JoinSwaggerElements("schemas", component, joinedSchemas);
            }
        }

        return new Dictionary<string, object>()
        {
            { "schemas", joinedSchemas }
        };
    }

    private void JoinSwaggerElements(string path, JsonElement source, in IDictionary<string, JsonElement> result)
    {
        if (source.TryGetProperty(path, out JsonElement element))
        {
            foreach (var property in element.EnumerateObject())
            {
                if (!result.ContainsKey(property.Name)){
                    result.Add(property.Name, property.Value);
                }
            }
        }
    }

    private IReadOnlyDictionary<string, JsonElement> JoinPaths(IEnumerable<JsonElement> sources)
    {
        var result = new Dictionary<string, JsonElement>();
        foreach (var source in sources)
        {
            if (
                source.TryGetProperty("paths", out JsonElement endpoints) &&
                source.TryGetProperty("info", out JsonElement infoElement) &&
                infoElement.TryGetProperty("title", out JsonElement titleElement)
            )
            {
                var title = titleElement.GetString()?.ToLower();
                var endpointsMap = OcelotConfiguration.ServiceRouteMap
                    .First(x => x.Key.Equals(title, StringComparison.OrdinalIgnoreCase));

                foreach (var endpoint in endpoints.EnumerateObject())
                {
                    var endpointOriginalPath = endpoint.Name;
                    var endpointSwagger = endpoint.Value;
                    var endpointPath = endpointsMap.Value
                        .Where(gatewayToOriginalMap => 
                            endpointOriginalPath.StartsWith(gatewayToOriginalMap.Value, StringComparison.OrdinalIgnoreCase)
                        )
                        .Select(gatewayToOriginalMap => 
                            endpointOriginalPath.Replace(gatewayToOriginalMap.Value, gatewayToOriginalMap.Key, StringComparison.OrdinalIgnoreCase)
                        )
                        .FirstOrDefault() ?? endpointOriginalPath;

                    result.Add(endpointPath, endpointSwagger);
                }
            }
        }

        return result;
    }
}
