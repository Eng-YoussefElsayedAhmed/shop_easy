using ShopEasy.API.Models;

namespace ShopEasy.API.Repositories;

public interface IProductRepository
{
    Task<IEnumerable<Product>> GetAllAsync();
    Task<Product?> GetByIdAsync(string id);
    Task<IEnumerable<Product>> SearchAsync(string query, string? category = null);
    Task<IEnumerable<string>> GetCategoriesAsync();
}
