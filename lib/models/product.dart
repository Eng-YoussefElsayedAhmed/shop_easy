class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final double? oldPrice;
  final double rating;
  final int reviews;
  final String description;
  final List<String> features;
  final String imageUrl;
  final double? discountPercent;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    this.oldPrice,
    required this.rating,
    required this.reviews,
    required this.description,
    required this.features,
    required this.imageUrl,
    this.discountPercent,
  });

  double get effectiveDiscount {
    if (discountPercent != null) return discountPercent!;
    if (oldPrice != null && oldPrice! > price) {
      return ((oldPrice! - price) / oldPrice! * 100).roundToDouble();
    }
    return 0;
  }
}
