using CatalogService.Application.Common.Interfaces;

namespace CatalogService.Application.Products.Commands.DeleteProduct
{
    public class DeleteProductHandler(IApplicationDbContext dbContext) : IRequestHandler<DeleteProductCommand>
    {
        private readonly IApplicationDbContext _dbContext = dbContext;

        public async Task Handle(DeleteProductCommand request, CancellationToken cancellationToken)
        {
            var product = await _dbContext.Produts.FindAsync([request.Id], cancellationToken);

            Guard.Against.NotFound(request.Id, product);

            _dbContext.Produts.Remove(product);

            await _dbContext.SaveAsync(cancellationToken);
        }
    }
}
