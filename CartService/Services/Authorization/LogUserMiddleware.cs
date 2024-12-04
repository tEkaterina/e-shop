using System.Security.Claims;

namespace CartService.Services.Authorization;

public class LogUserMiddleware(ILogger<LogUserMiddleware> logger) : IMiddleware
{
    public Task InvokeAsync(HttpContext context, RequestDelegate next)
    {
        if (context.User.Identity != null && context.User.Identity.IsAuthenticated)
        {
            var name = context.User.Claims.FirstOrDefault(x => x.Type.Equals("name"));
            var username = context.User.Claims.FirstOrDefault(x => x.Type.Equals("username"));
            var roles = string.Join(";",
                context.User.Claims.Where(x => x.Type.Equals(ClaimTypes.Role)).Select(x => x.Value)
            );

            var message = $"User {username} ({name}) with roles {roles} making [{context.Request.Method} {context.Request.Path}]";
            logger.LogInformation(message);
        }

        return next(context);
    }
}
