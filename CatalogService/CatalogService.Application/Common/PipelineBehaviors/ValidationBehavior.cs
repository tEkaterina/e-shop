using FluentValidation;

namespace CatalogService.Application.Common.PipelineBehaviors
{
    public class ValidationBehavior<TRequest, TResponse>(IEnumerable<IValidator<TRequest>> validators) : IPipelineBehavior<TRequest, TResponse>
         where TRequest : notnull
    {
        private readonly IEnumerable<IValidator<TRequest>> _validators = validators;

        public async Task<TResponse> Handle(TRequest request, RequestHandlerDelegate<TResponse> next, CancellationToken cancellationToken)
        {
            if (!_validators.Any())
            {
                return await next();
            }

            var results = await Task.WhenAll(_validators.Select(x => x.ValidateAsync(request, cancellationToken)));

            var errors = results.Where(x => !x.IsValid).SelectMany(x => x.Errors).ToArray();

            if (errors.Length != 0)
            {
                throw new ValidationException(errors);
            }

            return await next();
        }
    }
}
