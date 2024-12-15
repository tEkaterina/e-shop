using ApiGateway.Aggregators.Entities;
using Ocelot.Middleware;
using Ocelot.Multiplexer;
using System.Net;
using System.Text.Json;

namespace ApiGateway.Aggregators;

public class DetailedProductAggregator : IDefinedAggregator
{
    public async Task<DownstreamResponse> Aggregate(List<HttpContext> responseContexts)
    {
        var responses = responseContexts.Select(x => x.Items.DownstreamResponse()).ToArray();

        var productContent = await responses[0].Content.ReadAsStringAsync().ConfigureAwait(true);
        var productDetailsContent = await responses[1].Content.ReadAsStringAsync().ConfigureAwait(true);

        var product = JsonSerializer.Deserialize<DetailedProduct>(productContent) ?? throw new ApplicationException("Unable to parse product basics.");

        var details = JsonSerializer.Deserialize<Dictionary<string, string>>(productDetailsContent) ?? throw new ApplicationException("Unable to parse product details.");
        product.Attributes = details;

        var serializedResult = JsonSerializer.Serialize(product);

        return new DownstreamResponse(
            new StringContent(serializedResult),
            HttpStatusCode.OK,
            responses.SelectMany(x => x.Headers).ToList(),
            "OK"
        );
    }
}
