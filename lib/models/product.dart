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
  final String imagePath;
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
    required this.imagePath,
    this.discountPercent,
  });

  /// Alias for backward compatibility if needed
  String get imageUrl => imagePath;

  double get effectiveDiscount {
    if (discountPercent != null) return discountPercent!;
    if (oldPrice != null && oldPrice! > price) {
      return ((oldPrice! - price) / oldPrice! * 100).roundToDouble();
    }
    return 0;
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      category: json['category'] as String? ?? 'General',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      oldPrice: (json['oldPrice'] as num?)?.toDouble(),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviews: (json['reviews'] as num?)?.toInt() ?? 0,
      description: json['description'] as String? ?? '',
      features: (json['features'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      imagePath: (json['imagePath'] ?? json['imageUrl']) as String? ??
          'assets/images/headphones.png',
      discountPercent: (json['discountPercent'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
      'oldPrice': oldPrice,
      'rating': rating,
      'reviews': reviews,
      'description': description,
      'features': features,
      'imagePath': imagePath,
      'discountPercent': discountPercent,
    };
  }

  Product copyWith({
    String? id,
    String? name,
    String? category,
    double? price,
    double? oldPrice,
    double? rating,
    int? reviews,
    String? description,
    List<String>? features,
    String? imagePath,
    double? discountPercent,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      oldPrice: oldPrice ?? this.oldPrice,
      rating: rating ?? this.rating,
      reviews: reviews ?? this.reviews,
      description: description ?? this.description,
      features: features ?? this.features,
      imagePath: imagePath ?? this.imagePath,
      discountPercent: discountPercent ?? this.discountPercent,
    );
  }
}
