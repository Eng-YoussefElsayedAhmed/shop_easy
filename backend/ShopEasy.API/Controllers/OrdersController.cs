using Microsoft.AspNetCore.Mvc;
using ShopEasy.API.Models;
using ShopEasy.API.Repositories;

namespace ShopEasy.API.Controllers;

[ApiController]
[Route("api/[controller]")]
public class OrdersController : ControllerBase
{
    private readonly IOrderRepository _orderRepository;

    public OrdersController(IOrderRepository orderRepository)
    {
        _orderRepository = orderRepository;
    }

    /// <summary>
    /// Handles cart checkout simulation and order placement.
    /// </summary>
    [HttpPost("checkout")]
    [ProducesResponseType(typeof(CheckoutResponse), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<IActionResult> Checkout([FromBody] CheckoutRequest request)
    {
        if (request == null || request.Items == null || request.Items.Count == 0)
        {
            return BadRequest(new { message = "Cart is empty. Cannot checkout without items." });
        }

        var response = await _orderRepository.ProcessCheckoutAsync(request);
        return Ok(response);
    }
}
