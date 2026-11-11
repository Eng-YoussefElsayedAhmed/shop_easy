import '../models/product.dart';

final List<Product> sampleProducts = [
  Product(
    id: '1',
    name: 'Wireless Headphones',
    category: 'Electronics',
    price: 49.99,
    oldPrice: 79.99,
    rating: 4.5,
    reviews: 128,
    description:
        'Experience crystal-clear audio with our premium wireless headphones. '
        'Featuring advanced noise cancellation, 30-hour battery life, and '
        'ultra-comfortable memory foam ear cushions for all-day wear.',
    features: ['Deep Bass', '30h Battery', 'Noise Cancel', 'Foldable'],
    imagePath: 'assets/images/headphones.png',
    discountPercent: 38,
  ),
  Product(
    id: '2',
    name: 'Smart Watch',
    category: 'Electronics',
    price: 79.99,
    oldPrice: 129.99,
    rating: 4.3,
    reviews: 95,
    description:
        'Stay connected and track your health with our feature-packed smart watch. '
        'Monitor heart rate, sleep patterns, and fitness goals from your wrist. '
        'Compatible with iOS and Android.',
    features: ['Heart Rate', 'GPS', 'Waterproof', '7-Day Battery'],
    imagePath: 'assets/images/smartwatch.png',
    discountPercent: 38,
  ),
  Product(
    id: '3',
    name: 'Backpack',
    category: 'Bags',
    price: 29.99,
    oldPrice: 49.99,
    rating: 4.7,
    reviews: 214,
    description:
        'A versatile, durable backpack perfect for work, travel, or outdoor adventures. '
        'Multiple compartments, padded laptop sleeve (up to 15.6"), and ergonomic '
        'shoulder straps for maximum comfort.',
    features: ['Waterproof', 'Laptop Slot', 'USB Port', '30L Capacity'],
    imagePath: 'assets/images/backpack.png',
    discountPercent: 40,
  ),
  Product(
    id: '4',
    name: 'Sneakers',
    category: 'Fashion',
    price: 59.99,
    oldPrice: 89.99,
    rating: 4.6,
    reviews: 183,
    description:
        'Step into style with our premium sneakers. Lightweight mesh upper, '
        'responsive cushioning, and a sleek design make these perfect for everyday '
        'wear. Available in multiple colors.',
    features: ['Lightweight', 'Breathable', 'Non-slip', 'Stylish'],
    imagePath: 'assets/images/sneakers.png',
    discountPercent: 33,
  ),
  Product(
    id: '5',
    name: 'Bluetooth Speaker',
    category: 'Electronics',
    price: 39.99,
    oldPrice: 59.99,
    rating: 4.4,
    reviews: 76,
    description:
        'Portable 360-degree surround sound speaker with deep bass and crisp highs. '
        'IPX7 waterproof rating and 12-hour playtime make it perfect for any adventure.',
    features: ['360° Sound', 'Waterproof', '12h Play', 'USB-C Charge'],
    imagePath: 'assets/images/Bluetooth-Speaker.jfif',
    discountPercent: 33,
  ),
  Product(
    id: '6',
    name: 'Sunglasses',
    category: 'Fashion',
    price: 24.99,
    oldPrice: 39.99,
    rating: 4.2,
    reviews: 61,
    description:
        'UV400 polarized sunglasses with a classic aviator frame. Scratch-resistant '
        'lenses and lightweight titanium frame for all-day comfort.',
    features: ['UV400', 'Polarized', 'Lightweight', 'Unisex'],
    imagePath: 'assets/images/Sun-Glasses.png',
    discountPercent: 37,
  ),
  Product(
    id: '7',
    name: 'Perfume',
    category: 'Beauty',
    price: 44.99,
    oldPrice: 69.99,
    rating: 4.8,
    reviews: 309,
    description:
        'A luxurious fragrance with top notes of bergamot and lemon, heart notes of '
        'jasmine and rose, and a warm base of sandalwood and musk. Long-lasting 12+ hours.',
    features: ['Long Lasting', 'Floral & Musk', '100ml', 'Alcohol-Free'],
    imagePath: 'assets/images/Perfume.jfif',
    discountPercent: 36,
  ),
  Product(
    id: '8',
    name: 'Coffee Maker',
    category: 'Home & Living',
    price: 54.99,
    oldPrice: 84.99,
    rating: 4.5,
    reviews: 142,
    description:
        'Brew the perfect cup every time with our programmable coffee maker. '
        '12-cup capacity, built-in grinder, and a keep-warm plate. Supports '
        'multiple brew strengths.',
    features: ['12-Cup', 'Built-in Grinder', 'Keep Warm', 'Programmable'],
    imagePath: 'assets/images/Coffee-Maker.jfif',
    discountPercent: 35,
  ),
];
