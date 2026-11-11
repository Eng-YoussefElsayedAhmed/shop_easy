using System.Collections.Concurrent;
using ShopEasy.API.Models;

namespace ShopEasy.API.Repositories;

public class OrderRepository : IOrderRepository
{
    private static readonly ConcurrentDictionary<string, CheckoutRequest> _orders = new();

    public Task<CheckoutResponse> ProcessCheckoutAsync(CheckoutRequest request)
    {
        var orderId = $"ORD-{DateTime.UtcNow:yyyyMMdd}-{Guid.NewGuid().ToString("N")[..6].ToUpperInvariant()}";
        _orders[orderId] = request;

        var itemCount = request.Items?.Sum(i => i.Quantity) ?? 0;
        var totalAmount = request.Total > 0 ? request.Total : (request.Items?.Sum(i => i.TotalPrice) ?? 0m);

        var response = new CheckoutResponse
        {
            OrderId = orderId,
            Success = true,
            Message = "Order placed successfully! Thank you for shopping with ShopEasy.",
            OrderDate = DateTime.UtcNow,
            TotalAmount = totalAmount,
            ItemCount = itemCount
        };

        return Task.FromResult(response);
    }
}
