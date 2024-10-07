using FluentValidation;

namespace CatalogService.Application.Common.Extensions.Validators
{
    internal static class UrlFluentValidation
    {
        internal static IRuleBuilderOptions<T, string?> ValidUrl<T>(this IRuleBuilder<T, string?> ruleBuilder)
        {
            return ruleBuilder.Must(IsValidUrl).WithMessage("Invalid URL format.");
        }

        private static bool IsValidUrl(string? url)
        {
            if (string.IsNullOrEmpty(url))
                return true;

            return !(!Uri.TryCreate(url, UriKind.Absolute, out Uri? validatedUri)
                || validatedUri.Scheme != Uri.UriSchemeHttp && validatedUri.Scheme != Uri.UriSchemeHttps);
        }
    }
}
