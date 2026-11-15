import 'dart:convert';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;

import '../data/products_data.dart';
import '../models/cart_item.dart';
import '../models/product.dart';
import 'custom_http_client.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal() : _client = getCustomHttpClient();

  final http.Client _client;

  /// Live API endpoint specified for the project
  static const String liveApiEndpoint =
      'https://192.168.21.240:5001/api/products';

  String productsUrl = liveApiEndpoint;

  bool _isOnline = false;
  bool get isOnline => _isOnline;

  final Duration _timeout = const Duration(seconds: 6);

  /// Fetch products dynamically from the live API (`https://192.168.21.240:5001/api/products`).
  /// Self-signed SSL certificate errors are bypassed via custom HttpOverrides/HttpClient.
  Future<List<Product>> getProducts() async {
    final uri = Uri.parse(productsUrl);
    try {
      dev.log('Connecting to Live API: $uri', name: 'ApiService');
      final response = await _client.get(uri).timeout(_timeout);

      if (response.statusCode == 200) {
        final dynamic decoded = jsonDecode(response.body);
        if (decoded is List) {
          _isOnline = true;
          dev.log('Successfully fetched ${decoded.length} products from Live API',
              name: 'ApiService');
          return decoded
              .map((json) => Product.fromJson(json as Map<String, dynamic>))
              .toList();
        }
      } else {
        dev.log('Live API responded with status ${response.statusCode}',
            name: 'ApiService');
      }
    } catch (e) {
      dev.log('Live API connection failed: $e. Falling back to local data.',
          name: 'ApiService');
    }

    _isOnline = false;
    return List<Product>.from(sampleProducts);
  }

  /// Fetch single product by ID
  Future<Product?> getProductById(String id) async {
    final products = await getProducts();
    try {
      return products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Search products by keyword and optional category
  Future<List<Product>> searchProducts({
    required String query,
    String? category,
  }) async {
    final allProducts = await getProducts();
    final cleanQuery = query.trim().toLowerCase();
    final cleanCategory = category?.trim() ?? 'All';

    return allProducts.where((p) {
      final matchesQuery = cleanQuery.isEmpty ||
          p.title.toLowerCase().contains(cleanQuery) ||
          p.description.toLowerCase().contains(cleanQuery) ||
          p.category.toLowerCase().contains(cleanQuery);
      final matchesCategory =
          cleanCategory == 'All' || p.category == cleanCategory;
      return matchesQuery && matchesCategory;
    }).toList();
  }

  /// Get distinct categories list
  Future<List<String>> getCategories() async {
    final allProducts = await getProducts();
    final set = <String>{'All'};
    for (final p in allProducts) {
      set.add(p.category);
    }
    return set.toList();
  }

  /// Process checkout simulation
  Future<Map<String, dynamic>> checkout({
    required List<CartItem> items,
    required double subtotal,
    required double shipping,
    required double total,
    String? fullName,
    String? email,
  }) async {
    final orderId =
        'ORD-${DateTime.now().year}${(DateTime.now().millisecondsSinceEpoch % 1000000).toString().padLeft(6, '0')}';

    return {
      'orderId': orderId,
      'success': true,
      'message': 'Order placed successfully! Thank you for shopping with ShopEasy.',
      'totalAmount': total,
      'itemCount': items.fold<int>(0, (sum, i) => sum + i.quantity),
    };
  }
}
