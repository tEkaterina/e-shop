using CatalogService.Application.Common.Models;
using CatalogService.Application.Products.Commands.CreateProduct;
using CatalogService.Application.Products.Commands.DeleteProduct;
using CatalogService.Application.Products.Commands.UpdateProduct;
using CatalogService.Application.Products.Queries.Common.Dto;
using CatalogService.Application.Products.Queries.GetProduct;
using CatalogService.Application.Products.Queries.GetProducts;

using MediatR;

using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace CatalogService.Web.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class ProductsController : ControllerBase
    {
        [HttpGet]
        public Task<PaginatedList<ProductDto>> Get(
            [FromServices] ISender sender,
            [FromQuery] GetProductsQuery query
            )
        {
            return sender.Send(query);
        }

        [HttpGet("{id}")]
        public Task<ProductDto> Get(
            [FromServices] ISender sender,
            [FromRoute] GetProductQuery query
            )
        {
            return sender.Send(query);
        }

        [HttpGet("{id}/details")]
        public IReadOnlyDictionary<string, string> GetDetails(int id)
        {
            return new Dictionary<string, string>
           {
               {"Accessed", DateTime.Now.ToString()},
               {"Condition", "New"},
               {"Producer", "Company 123 & Co"}
           };
        }

        [HttpPost]
        [Authorize(Policy = "Manager")]
        public Task<int> Create(
            [FromServices] ISender sender,
            [FromBody] CreateProductCommand command
        )
        {
            return sender.Send(command);
        }

        [HttpPut("{id}")]
        [Authorize(Policy = "Manager")]
        public async Task<IResult> Update([FromServices] ISender sender, int id, [FromBody] UpdateProductCommand command)
        {
            if (id != command.Id)
            {
                return Results.BadRequest();
            }

            await sender.Send(command).ConfigureAwait(false);

            return Results.NoContent();
        }

        [HttpDelete("{id}")]
        [Authorize(Policy = "Manager")]
        public async Task<IResult> Delete([FromServices] ISender sender, int id, [FromRoute] DeleteProductCommand command)
        {
            if (id != command.Id)
            {
                return Results.BadRequest();
            }

            await sender.Send(command).ConfigureAwait(false);

            return Results.NoContent();
        }
    }
}
