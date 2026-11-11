namespace ShopEasy.API.Models;

public class CartItemDto
{
    public string ProductId { get; set; } = string.Empty;
    public string ProductName { get; set; } = string.Empty;
    public decimal UnitPrice { get; set; }
    public int Quantity { get; set; } = 1;
    public decimal TotalPrice => UnitPrice * Quantity;
}

public class CustomerInfoDto
{
    public string FullName { get; set; } = "ShopEasy Customer";
    public string Email { get; set; } = "customer@example.com";
    public string Address { get; set; } = "123 Main Street";
    public string City { get; set; } = "Cairo";
}

public class CheckoutRequest
{
    public List<CartItemDto> Items { get; set; } = new();
    public CustomerInfoDto? Customer { get; set; }
    public decimal Subtotal { get; set; }
    public decimal Shipping { get; set; } = 0.00m;
    public decimal Total { get; set; }
}

public class CheckoutResponse
{
    public string OrderId { get; set; } = string.Empty;
    public bool Success { get; set; } = true;
    public string Message { get; set; } = string.Empty;
    public DateTime OrderDate { get; set; } = DateTime.UtcNow;
    public decimal TotalAmount { get; set; }
    public int ItemCount { get; set; }
}
