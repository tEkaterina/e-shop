namespace ApiGateway.Aggregators.Entities;

public record DetailedProduct : Product
{
    public IReadOnlyDictionary<string, string>? Attributes { get; set; }
}
