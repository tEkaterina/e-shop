using CartService.DataAccess.Entities;
using CartService.DataAccess.Repository;
using CartService.Services.Dto;
using CartService.Services.Exceptions;
using CartService.Services.Mappers;
using CartService.Services.Product;

namespace CartService.Services.Cart
{
    public class CartService(ICartMapper mapper, ICartRepository cartRepository, IProductService productService) : ICartService
    {
        private readonly ICartMapper _mapper = mapper;
        private readonly ICartRepository _cartRepository = cartRepository;
        private readonly IProductService _productService = productService;

        public async Task<CartDto?> GetAsync(string cartId)
        {
            CartEntity? cart = _cartRepository.GetCart(cartId);

            return cart == null ? null : await _mapper.ToCartDtoAsync(cart);
        }

        public async Task<CartDto> GetOrCreateAsync(string cartId)
        {
            CartEntity cart = GetOrCreateCartEntity(cartId);

            return await _mapper.ToCartDtoAsync(cart);
        }

        public bool Delete(string cartId)
        {
            return _cartRepository.DeleteCart(cartId);
        }

        public bool DeleteProduct(string cartId, int productId, int? count = null)
        {
            CartEntity cart = _cartRepository.GetCart(cartId) ?? throw new CartNotFoundException(cartId);
            ProductItemEntity existingProduct = cart.ProductItems.FirstOrDefault(p => p.Id == productId) ?? throw new ProductNotFoundException(productId);

            if (count.HasValue)
            {
                existingProduct.Count -= count.Value;
            }

            if (!count.HasValue || existingProduct.Count <= 0)
            {
                cart.ProductItems.Remove(existingProduct);
            }

            _cartRepository.SaveCart(cart);

            return true;
        }

        public async Task<CartDto> AddProductAsync(string cartId, int productId, int count = 1)
        {
            CartEntity cart = GetOrCreateCartEntity(cartId);
            var existingProduct = cart.ProductItems.FirstOrDefault(p => p.Id == productId);

            if (existingProduct != null)
            {
                existingProduct.Count += count;
            }
            else
            {
                ProductDto product = await _productService.GetProductAsync(productId) ?? throw new ProductNotFoundException(productId);
                cart.ProductItems.Add(_mapper.ToProductItem(product));
            }

            _cartRepository.SaveCart(cart);

            return await _mapper.ToCartDtoAsync(cart);
        }

        private CartEntity GetOrCreateCartEntity(string cartId)
        {
            CartEntity? cart = _cartRepository.GetCart(cartId);
            if (cart != null)
            {
                return cart;
            }

            var newCart = new CartEntity { Id = cartId };
            if (!_cartRepository.SaveCart(newCart))
            {
                throw new CartCreateException(cartId);
            }

            return newCart;
        }
    }
}
