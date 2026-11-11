using System.Collections.Concurrent;
using ShopEasy.API.Models;

namespace ShopEasy.API.Repositories;

public class ProductRepository : IProductRepository
{
    private static readonly ConcurrentDictionary<string, Product> _products = new();

    static ProductRepository()
    {
        var initialProducts = new List<Product>
        {
            new()
            {
                Id = "1",
                Name = "Wireless Headphones",
                Category = "Electronics",
                Price = 49.99m,
                OldPrice = 79.99m,
                Rating = 4.5,
                Reviews = 128,
                Description = "Experience crystal-clear audio with our premium wireless headphones. " +
                              "Featuring advanced noise cancellation, 30-hour battery life, and " +
                              "ultra-comfortable memory foam ear cushions for all-day wear.",
                Features = new List<string> { "Deep Bass", "30h Battery", "Noise Cancel", "Foldable" },
                ImagePath = "assets/images/headphones.png",
                DiscountPercent = 38
            },
            new()
            {
                Id = "2",
                Name = "Smart Watch",
                Category = "Electronics",
                Price = 79.99m,
                OldPrice = 129.99m,
                Rating = 4.3,
                Reviews = 95,
                Description = "Stay connected and track your health with our feature-packed smart watch. " +
                              "Monitor heart rate, sleep patterns, and fitness goals from your wrist. " +
                              "Compatible with iOS and Android.",
                Features = new List<string> { "Heart Rate", "GPS", "Waterproof", "7-Day Battery" },
                ImagePath = "assets/images/smartwatch.png",
                DiscountPercent = 38
            },
            new()
            {
                Id = "3",
                Name = "Backpack",
                Category = "Bags",
                Price = 29.99m,
                OldPrice = 49.99m,
                Rating = 4.7,
                Reviews = 214,
                Description = "A versatile, durable backpack perfect for work, travel, or outdoor adventures. " +
                              "Multiple compartments, padded laptop sleeve (up to 15.6\"), and ergonomic " +
                              "shoulder straps for maximum comfort.",
                Features = new List<string> { "Waterproof", "Laptop Slot", "USB Port", "30L Capacity" },
                ImagePath = "assets/images/backpack.png",
                DiscountPercent = 40
            },
            new()
            {
                Id = "4",
                Name = "Sneakers",
                Category = "Fashion",
                Price = 59.99m,
                OldPrice = 89.99m,
                Rating = 4.6,
                Reviews = 183,
                Description = "Step into style with our premium sneakers. Lightweight mesh upper, " +
                              "responsive cushioning, and a sleek design make these perfect for everyday " +
                              "wear. Available in multiple colors.",
                Features = new List<string> { "Lightweight", "Breathable", "Non-slip", "Stylish" },
                ImagePath = "assets/images/sneakers.png",
                DiscountPercent = 33
            },
            new()
            {
                Id = "5",
                Name = "Bluetooth Speaker",
                Category = "Electronics",
                Price = 39.99m,
                OldPrice = 59.99m,
                Rating = 4.4,
                Reviews = 76,
                Description = "Portable 360-degree surround sound speaker with deep bass and crisp highs. " +
                              "IPX7 waterproof rating and 12-hour playtime make it perfect for any adventure.",
                Features = new List<string> { "360° Sound", "Waterproof", "12h Play", "USB-C Charge" },
                ImagePath = "assets/images/Bluetooth-Speaker.jfif",
                DiscountPercent = 33
            },
            new()
            {
                Id = "6",
                Name = "Sunglasses",
                Category = "Fashion",
                Price = 24.99m,
                OldPrice = 39.99m,
                Rating = 4.2,
                Reviews = 61,
                Description = "UV400 polarized sunglasses with a classic aviator frame. Scratch-resistant " +
                              "lenses and lightweight titanium frame for all-day comfort.",
                Features = new List<string> { "UV400", "Polarized", "Lightweight", "Unisex" },
                ImagePath = "assets/images/Sun-Glasses.png",
                DiscountPercent = 37
            },
            new()
            {
                Id = "7",
                Name = "Perfume",
                Category = "Beauty",
                Price = 44.99m,
                OldPrice = 69.99m,
                Rating = 4.8,
                Reviews = 309,
                Description = "A luxurious fragrance with top notes of bergamot and lemon, heart notes of " +
                              "jasmine and rose, and a warm base of sandalwood and musk. Long-lasting 12+ hours.",
                Features = new List<string> { "Long Lasting", "Floral & Musk", "100ml", "Alcohol-Free" },
                ImagePath = "assets/images/Perfume.jfif",
                DiscountPercent = 36
            },
            new()
            {
                Id = "8",
                Name = "Coffee Maker",
                Category = "Home & Living",
                Price = 54.99m,
                OldPrice = 84.99m,
                Rating = 4.5,
                Reviews = 142,
                Description = "Brew the perfect cup every time with our programmable coffee maker. " +
                              "12-cup capacity, built-in grinder, and a keep-warm plate. Supports " +
                              "multiple brew strengths.",
                Features = new List<string> { "12-Cup", "Built-in Grinder", "Keep Warm", "Programmable" },
                ImagePath = "assets/images/Coffee-Maker.jfif",
                DiscountPercent = 35
            }
        };

        foreach (var p in initialProducts)
        {
            _products[p.Id] = p;
        }
    }

    public Task<IEnumerable<Product>> GetAllAsync()
    {
        return Task.FromResult<IEnumerable<Product>>(_products.Values.OrderBy(p => int.Parse(p.Id)).ToList());
    }

    public Task<Product?> GetByIdAsync(string id)
    {
        _products.TryGetValue(id, out var product);
        return Task.FromResult(product);
    }

    public Task<IEnumerable<Product>> SearchAsync(string query, string? category = null)
    {
        var cleanQuery = query?.Trim().ToLowerInvariant() ?? string.Empty;
        var cleanCategory = category?.Trim();

        var queryable = _products.Values.AsEnumerable();

        if (!string.IsNullOrEmpty(cleanCategory) && !cleanCategory.Equals("All", StringComparison.OrdinalIgnoreCase))
        {
            queryable = queryable.Where(p => p.Category.Equals(cleanCategory, StringComparison.OrdinalIgnoreCase));
        }

        if (!string.IsNullOrEmpty(cleanQuery))
        {
            queryable = queryable.Where(p =>
                p.Name.ToLowerInvariant().Contains(cleanQuery) ||
                p.Category.ToLowerInvariant().Contains(cleanQuery) ||
                p.Description.ToLowerInvariant().Contains(cleanQuery));
        }

        return Task.FromResult<IEnumerable<Product>>(queryable.OrderBy(p => int.Parse(p.Id)).ToList());
    }

    public Task<IEnumerable<string>> GetCategoriesAsync()
    {
        var categories = _products.Values
            .Select(p => p.Category)
            .Distinct(StringComparer.OrdinalIgnoreCase)
            .OrderBy(c => c)
            .ToList();

        return Task.FromResult<IEnumerable<string>>(categories);
    }
}
