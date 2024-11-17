using CartService.DataAccess.Common.Entities;
using CartService.Services.Common.Dto;
using CartService.Services.Common.Exceptions;
using CartService.Services.Product;
using CartService.DataAccess.Repository.Cart;
using CartService.Services.Cart.Mappers;

namespace CartService.Services.Cart
{
    public class CartService(ICartMapper mapper, ICartRepository cartRepository, IProductService productService) : ICartService
    {
        private readonly ICartMapper _mapper = mapper;
        private readonly ICartRepository _cartRepository = cartRepository;
        private readonly IProductService _productService = productService;

        public async Task<CartDto> GetAsync(string cartId)
        {
            CartEntity? cart = _cartRepository.GetCart(cartId);

            Guard.Against.NotFound(cartId, cart);

            return _mapper.ToCartDto(cart);
        }

        public async Task<CartDto> GetOrCreateAsync(string cartId)
        {
            CartEntity cart = GetOrCreateCartEntity(cartId);

            return _mapper.ToCartDto(cart);
        }

        public bool Delete(string cartId)
        {
            return _cartRepository.DeleteCart(cartId);
        }

        public bool DeleteProduct(string cartId, int productId, int? count = null)
        {
            CartEntity? cart = _cartRepository.GetCart(cartId);

            Guard.Against.NotFound(cartId, cart);

            AddedProductEntity? existingProduct = cart.Products.FirstOrDefault(p => p.ProductId == productId);

            Guard.Against.NotFound(productId, existingProduct);

            if (count.HasValue)
            {
                existingProduct.Count -= count.Value;
            }

            if (!count.HasValue || existingProduct.Count <= 0)
            {
                cart.Products.Remove(existingProduct);
            }

            _cartRepository.SaveCart(cart);

            return true;
        }

        public async Task<CartDto> AddProductAsync(string cartId, int productId, int count = 1)
        {
            CartEntity cart = GetOrCreateCartEntity(cartId);
            var existingProduct = cart.Products.FirstOrDefault(p => p.ProductId == productId);

            if (existingProduct != null)
            {
                existingProduct.Count += count;
            }
            else
            {
                ProductDto? product = _productService.GetProduct(productId);

                Guard.Against.NotFound(productId, product);

                product.Count = count;
                cart.Products.Add(_mapper.ToAddedProduct(product));
            }

            if (!_cartRepository.SaveCart(cart))
            {
                throw new CartCreateException(cartId);
            }

            return _mapper.ToCartDto(cart);
        }

        private CartEntity GetOrCreateCartEntity(string cartId)
        {
            CartEntity? cart = _cartRepository.GetCart(cartId);
            if (cart != null)
            {
                return cart;
            }

            var newCart = new CartEntity(cartId);
            if (!_cartRepository.SaveCart(newCart))
            {
                throw new CartCreateException(cartId);
            }

            return newCart;
        }
    }
}
