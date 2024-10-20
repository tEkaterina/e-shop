using FluentValidation.Results;

namespace CatalogService.Application.Common.Exceptions;

public class ValidationException() : Exception("One or more validation errors have happened.")
{
    public IDictionary<string, string[]> Errors { get; } = new Dictionary<string, string[]>();

    public ValidationException(IEnumerable<ValidationFailure> errors) : this()
    {
        Errors = errors
            .GroupBy(e => e.PropertyName, e => e.ErrorMessage)
            .ToDictionary(errorGroup => errorGroup.Key, errorGroup => errorGroup.ToArray());
    }
}
