using ApiGateway.Aggregators;

using Ocelot.DependencyInjection;

namespace ApiGateway.Core;

public static class OcelotConfigurator
{
    public static IServiceCollection AddGatewayServices(this IServiceCollection services)
    {
        services.AddOcelot().AddAggregators();

        return services;
    }

    public static IConfigurationManager AddGatewayConfig(this IConfigurationManager configuration)
    {
        configuration.AddJsonFile("ocelot.json");

        return configuration;
    }
}
