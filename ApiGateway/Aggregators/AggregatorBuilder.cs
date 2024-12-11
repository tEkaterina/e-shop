using Ocelot.DependencyInjection;

namespace ApiGateway.Aggregators;

public static class AggregatorBuilder
{
    public static IOcelotBuilder AddAggregators(this IOcelotBuilder ocelotBuilder)
    {
        ocelotBuilder.AddTransientDefinedAggregator<DetailedProductAggregator>();

        return ocelotBuilder;
    }
}
