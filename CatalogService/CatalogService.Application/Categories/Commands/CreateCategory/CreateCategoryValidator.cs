using CatalogService.Application.Common.Extensions.Validators;

using FluentValidation;

namespace CatalogService.Application.Categories.Commands.CreateCategory;

public class UpdateCategoryValidator : AbstractValidator<CreateCategoryCommand>
{
    public UpdateCategoryValidator()
    {
        RuleFor(x => x.Name).NotEmpty().MaximumLength(50);
        RuleFor(x => x.Image).ValidUrl();
    }
}
