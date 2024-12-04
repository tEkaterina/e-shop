using CatalogService.Application.Common.Extensions.Validators;
using CatalogService.Application.Common.Interfaces;

using FluentValidation;

namespace CatalogService.Application.Products.Commands.CreateProduct;

public class CreateProductValidator : AbstractValidator<CreateProductCommand>
{
    private readonly IApplicationDbContext _dbContext;

    public CreateProductValidator(IApplicationDbContext dbContext)
    {
        _dbContext = dbContext;

        RuleFor(x => x.Name).NotEmpty().MaximumLength(50);
        RuleFor(x => x.Price).GreaterThanOrEqualTo(0);
        RuleFor(x => x.Amount).GreaterThanOrEqualTo(0);
        RuleFor(x => x.Description).ValidHtml();
        RuleFor(x => x.Image).ValidUrl();
        RuleFor(x => x.CategoryId).MustAsync(IsValidCategory).WithMessage("Invalid category ID.");
    }

    private async Task<bool> IsValidCategory(int categoryId, CancellationToken cancellationToken)
    {
        var category = await _dbContext.Categories.FindAsync([categoryId], cancellationToken).ConfigureAwait(false);
        return category != null;
    }
}
