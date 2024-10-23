using FluentValidation;

namespace CatalogService.Application.Products.Queries.GetProducts;

public class GetProductsValidator : AbstractValidator<GetProductsQuery>
{
    public GetProductsValidator()
    {
        RuleFor(x => x.CategoryId).NotEmpty().WithMessage("Category ID must not be empty or null.");

        RuleFor(x => x.PageIndex).GreaterThan(0).WithMessage("Page index must be greater than 0.");

        RuleFor(x => x.PageSize).GreaterThan(0).WithMessage("Page size must be greater than 0.");
    }
}
