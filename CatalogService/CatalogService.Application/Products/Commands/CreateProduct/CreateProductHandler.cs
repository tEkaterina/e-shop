using CatalogService.Application.Common.Interfaces;

namespace CatalogService.Application.Products.Commands.CreateProduct
{
    public class CreateProductHandler(IApplicationDbContext dbContext) : IRequestHandler<CreateProductCommand, int>
    {
        private readonly IApplicationDbContext _dbContext = dbContext;

        public async Task<int> Handle(CreateProductCommand request, CancellationToken cancellationToken)
        {
            var product = new Product
            {
                Name = request.Name,
                Image = request.Image,
                Amount = request.Amount,
                CategoryId = request.CategoryId,
                Description = request.Description,
                Price = request.Price,
            };

            _dbContext.Products.Add(product);

            await _dbContext.SaveChangesAsync(cancellationToken).ConfigureAwait(false);

            return product.Id;
        }
    }
}
