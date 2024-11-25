using CatalogService.Application.Categories.Commands.CreateCategory;
using CatalogService.Application.Categories.Commands.DeleteCategory;
using CatalogService.Application.Categories.Commands.UpdateCategory;
using CatalogService.Application.Categories.Queries.Common.Dto;
using CatalogService.Application.Categories.Queries.GetCategories;
using CatalogService.Application.Categories.Queries.GetCategory;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace CatalogService.Web.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class CategoriesController : ControllerBase
    {
        [HttpGet]
        public Task<IReadOnlyCollection<CategoryDto>> Get([FromServices] ISender sender, [FromQuery] GetCategoriesQuery query)
        {
            return sender.Send(query);
        }

        [HttpGet("{id}")]
        public async Task<IResult> Get([FromServices] ISender sender, int id, [FromRoute] GetCategoryQuery query)
        {
            if (id != query.Id)
            {
                return Results.BadRequest();
            }

            return Results.Ok(await sender.Send(query));
        }

        [HttpPost]
        [Authorize(Policy = "Manager")]
        public Task<int> Create([FromServices] ISender sender, [FromBody] CreateCategoryCommand command)
        {
            return sender.Send(command);
        }

        [HttpPut("{id}")]
        [Authorize(Policy = "Manager")]
        public async Task<IResult> Update([FromServices] ISender sender, int id, [FromBody] UpdateCategoryCommand command)
        {
            if (id != command.Id)
            {
                return Results.BadRequest();
            }

            await sender.Send(command);

            return Results.NoContent();
        }

        [HttpDelete("{id}")]
        [Authorize(Policy = "Manager")]
        public async Task<IResult> Delete([FromServices] ISender sender, int id, [FromRoute] DeleteCategoryCommand command)
        {
            if (id != command.Id)
            {
                return Results.BadRequest();
            }

            await sender.Send(command);

            return Results.NoContent();
        }
    }
}
