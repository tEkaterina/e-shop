﻿using CatalogService.Application.Common.Interfaces;

namespace CatalogService.Application.Categories.Commands.DeleteCategory
{
    public class DeleteCategoryHandler(IApplicationDbContext dbContext) : IRequestHandler<DeleteCategoryCommand>
    {
        private readonly IApplicationDbContext _dbContext = dbContext;

        public async Task Handle(DeleteCategoryCommand request, CancellationToken cancellationToken)
        {
            var category = await _dbContext.Categories.FindAsync([request.Id], cancellationToken);

            Guard.Against.NotFound(request.Id, category);

            _dbContext.Categories.Remove(category);

            await _dbContext.SaveChangesAsync(cancellationToken);
        }
    }
}