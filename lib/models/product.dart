class Product {
  final String id;
  final String title;
  final double price;
  final String description;
  final String imgUrl;

  // Extra optional/derived properties for rich UI compatibility:
  final String category;
  final double? oldPrice;
  final double rating;
  final int reviews;
  final List<String> features;
  final double? discountPercent;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.imgUrl,
    this.category = 'Electronics',
    this.oldPrice,
    this.rating = 4.5,
    this.reviews = 120,
    this.features = const ['Premium Quality', 'Fast Shipping', '1-Year Warranty'],
    this.discountPercent,
  });

  /// Alias properties to ensure seamless backward compatibility with existing screens & widgets
  String get name => title;
  String get imagePath => imgUrl;
  String get imageUrl => imgUrl;

  double get effectiveDiscount {
    if (discountPercent != null) return discountPercent!;
    if (oldPrice != null && oldPrice! > price) {
      return ((oldPrice! - price) / oldPrice! * 100).roundToDouble();
    }
    return 0;
  }

  static String _cleanUrl(dynamic raw) {
    if (raw == null) return '';
    var s = raw.toString().trim();
    // Handle markdown-formatted URLs like [https://...](https://...)
    final match = RegExp(r'\[.*?\]\((https?://[^\)]+)\)').firstMatch(s);
    if (match != null) {
      return match.group(1) ?? s;
    }
    if (s.startsWith('[') && s.endsWith(']')) {
      s = s.substring(1, s.length - 1);
    }
    return s;
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    final title =
        (json['title'] ?? json['name'] ?? 'Untitled Product').toString();

    // Clean price parsing: handles int, double, string numbers cleanly
    double parsedPrice = 0.0;
    if (json['price'] != null) {
      if (json['price'] is num) {
        parsedPrice = (json['price'] as num).toDouble();
      } else {
        parsedPrice = double.tryParse(json['price'].toString()) ?? 0.0;
      }
    }

    final rawImage = json['imgUrl'] ?? json['imagePath'] ?? json['imageUrl'];
    final cleanImgUrl = _cleanUrl(rawImage);

    return Product(
      id: json['id']?.toString() ?? '',
      title: title,
      price: parsedPrice,
      description: json['description']?.toString() ?? '',
      imgUrl: cleanImgUrl,
      category: json['category']?.toString() ?? _inferCategory(title),
      oldPrice: (json['oldPrice'] as num?)?.toDouble(),
      rating: (json['rating'] as num?)?.toDouble() ?? 4.5,
      reviews: (json['reviews'] as num?)?.toInt() ?? 85,
      features: (json['features'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          _inferFeatures(title),
      discountPercent: (json['discountPercent'] as num?)?.toDouble(),
    );
  }

  static String _inferCategory(String title) {
    final lower = title.toLowerCase();
    if (lower.contains('headphone') ||
        lower.contains('keyboard') ||
        lower.contains('monitor') ||
        lower.contains('power bank') ||
        lower.contains('phone')) {
      return 'Electronics';
    }
    if (lower.contains('sneaker') ||
        lower.contains('shoe') ||
        lower.contains('shirt') ||
        lower.contains('dress') ||
        lower.contains('fashion')) {
      return 'Fashion';
    }
    if (lower.contains('backpack') || lower.contains('bag')) {
      return 'Bags';
    }
    if (lower.contains('fitness') ||
        lower.contains('watch') ||
        lower.contains('tracker')) {
      return 'Electronics';
    }
    return 'Electronics';
  }

  static List<String> _inferFeatures(String title) {
    final lower = title.toLowerCase();
    if (lower.contains('headphone')) {
      return ['Deep Bass', '30h Battery', 'Noise Cancel', 'Bluetooth 5.3'];
    }
    if (lower.contains('keyboard')) {
      return ['Mechanical', 'RGB Backlit', 'Tactile Switch', 'Anti-Ghosting'];
    }
    if (lower.contains('monitor')) {
      return ['4K Ultra-Wide', '144Hz Refresh', 'HDR10', 'Curved Display'];
    }
    if (lower.contains('tracker') || lower.contains('watch')) {
      return ['Heart Rate', 'Sleep Monitor', 'Waterproof', '7-Day Battery'];
    }
    if (lower.contains('power bank')) {
      return ['20,000mAh', 'Fast Charging', 'Dual USB-C', 'Compact'];
    }
    if (lower.contains('iphone')) {
      return ['Super Retina', 'A16 Bionic', 'Pro Camera', '5G Speed'];
    }
    return ['Premium Quality', 'Fast Shipping', '1-Year Warranty'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': int.tryParse(id) ?? id,
      'title': title,
      'price': price,
      'description': description,
      'imgUrl': imgUrl,
    };
  }

  Product copyWith({
    String? id,
    String? title,
    String? name,
    double? price,
    String? description,
    String? imgUrl,
    String? category,
    double? oldPrice,
    double? rating,
    int? reviews,
    List<String>? features,
    double? discountPercent,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? name ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      imgUrl: imgUrl ?? this.imgUrl,
      category: category ?? this.category,
      oldPrice: oldPrice ?? this.oldPrice,
      rating: rating ?? this.rating,
      reviews: reviews ?? this.reviews,
      features: features ?? this.features,
      discountPercent: discountPercent ?? this.discountPercent,
    );
  }
}
