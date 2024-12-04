using CatalogService.Application.Common.Interfaces;
using CatalogService.Domain.Events;

namespace CatalogService.Application.Products.Commands.UpdateProduct;

public class UpdateProductHandler(IApplicationDbContext dbContext, IApplicationMessagePublisher publisher) : IRequestHandler<UpdateProductCommand>
{
    private readonly IApplicationDbContext _dbContext = dbContext;

    public async Task Handle(UpdateProductCommand request, CancellationToken cancellationToken)
    {
        var product = await _dbContext.Products.FindAsync([request.Id], cancellationToken).ConfigureAwait(false);

        Guard.Against.NotFound(request.Id, product);

        product.Amount = request.Amount;
        product.Description = request.Description;
        product.Price = request.Price;
        product.CategoryId = request.CategoryId;
        product.Image = request.Image;
        product.Name = request.Name;

        await _dbContext.SaveChangesAsync(cancellationToken).ConfigureAwait(false);

        await publisher.PublishProductUpdateAsync(new ProductChangeEvent(request.Id, new ProductChangeDetails()
        {
            Description = request.Description,
            Image = request.Image,
            Name = request.Name,
            Price = request.Price
        })).ConfigureAwait(false);
    }
}
