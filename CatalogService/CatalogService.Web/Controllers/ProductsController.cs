using CatalogService.Application.Common.Models;
using CatalogService.Application.Products.Commands.CreateProduct;
using CatalogService.Application.Products.Commands.DeleteProduct;
using CatalogService.Application.Products.Commands.UpdateProduct;
using CatalogService.Application.Products.Queries.Common.Dto;
using CatalogService.Application.Products.Queries.GetProducts;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace CatalogService.Web.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
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

        [HttpPost]
        public Task<int> Create(
            [FromServices] ISender sender,
            [FromBody] CreateProductCommand command
        )
        {
            return sender.Send(command);
        }

        [HttpPut("{id}")]
        public async Task<IResult> Update([FromServices] ISender sender, int id, [FromBody] UpdateProductCommand command)
        {
            if (id != command.Id)
            {
                return Results.BadRequest();
            }

            await sender.Send(command);

            return Results.NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<IResult> Delete([FromServices] ISender sender, int id, [FromRoute] DeleteProductCommand command)
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
