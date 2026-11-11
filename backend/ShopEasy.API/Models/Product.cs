namespace ShopEasy.API.Models;

public class Product
{
    public string Id { get; set; } = string.Empty;
    public string Name { get; set; } = string.Empty;
    public string Category { get; set; } = string.Empty;
    public decimal Price { get; set; }
    public decimal? OldPrice { get; set; }
    public double Rating { get; set; }
    public int Reviews { get; set; }
    public string Description { get; set; } = string.Empty;
    public List<string> Features { get; set; } = new();
    public string ImagePath { get; set; } = string.Empty;
    public double? DiscountPercent { get; set; }

    public double EffectiveDiscount
    {
        get
        {
            if (DiscountPercent.HasValue) return DiscountPercent.Value;
            if (OldPrice.HasValue && OldPrice.Value > Price)
            {
                return (double)Math.Round(((OldPrice.Value - Price) / OldPrice.Value) * 100);
            }
            return 0;
        }
    }
}
