using ShopEasy.API.Models;

namespace ShopEasy.API.Repositories;

public interface IOrderRepository
{
    Task<CheckoutResponse> ProcessCheckoutAsync(CheckoutRequest request);
}
