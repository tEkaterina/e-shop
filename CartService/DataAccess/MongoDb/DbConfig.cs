namespace CartService.DataAccess.MongoDb;

public class DbConfig
{
    public required string DbName { get; set; }
    public required string CartCollectionName { get; set; }
    public required string ProductCollectionName { get; set; }
}
