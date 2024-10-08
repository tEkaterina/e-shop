using CatalogService.Application.Common.Interfaces;

namespace CatalogService.Application.Products.Commands.UpdateProduct;

public class UpdateProductHandler(IApplicationDbContext dbContext) : IRequestHandler<UpdateProductCommand>
{
    private readonly IApplicationDbContext _dbContext = dbContext;

    public async Task Handle(UpdateProductCommand request, CancellationToken cancellationToken)
    {
        var product = await this._dbContext.Products.FindAsync([request.Id], cancellationToken);

        Guard.Against.NotFound(request.Id, product);

        product.Amount = request.Amount;
        product.Description = request.Description;
        product.Price = request.Price;
        product.CategoryId = request.CategoryId;
        product.Image = request.Image;
        product.Name = request.Name;

        await _dbContext.SaveChangesAsync(cancellationToken);
    }
}
