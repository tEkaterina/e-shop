using FluentValidation;

using Ganss.Xss;

namespace CatalogService.Application.Common.Extensions.Validators
{
    internal static class HtmlFluentValidation
    {
        internal static IRuleBuilderOptions<T, string?> ValidHtml<T>(this IRuleBuilder<T, string?> ruleBuilder)
        {
            return ruleBuilder.Must(IsValidHtml).WithMessage("Invalid HTML content.");
        }

        private static bool IsValidHtml(string? htmlContent)
        {
            if (string.IsNullOrWhiteSpace(htmlContent))
                return true;

            var sanitizer = new HtmlSanitizer();
            var sanitized = sanitizer.Sanitize(htmlContent);

            return sanitized == htmlContent;
        }
    }
}
