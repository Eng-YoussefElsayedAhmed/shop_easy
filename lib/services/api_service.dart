import 'dart:convert';
import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../data/products_data.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  /// Default API base URL tailored for platform:
  /// - Android emulator uses 10.0.2.2 to reach host machine
  /// - Web / iOS / Windows / macOS uses localhost
  static String get defaultBaseUrl {
    if (kIsWeb) {
      return 'http://localhost:5091';
    }
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:5091';
    }
    return 'http://localhost:5091';
  }

  String _baseUrl = defaultBaseUrl;
  String get baseUrl => _baseUrl;
  set baseUrl(String url) => _baseUrl = url.replaceAll(RegExp(r'/+$'), '');

  bool _isOnline = false;
  bool get isOnline => _isOnline;

  final Duration _timeout = const Duration(seconds: 4);

  /// Fetch all products from API, with graceful fallback to local data.
  Future<List<Product>> getProducts() async {
    final uri = Uri.parse('$_baseUrl/api/products');
    try {
      final response = await http.get(uri).timeout(_timeout);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _isOnline = true;
        return data.map((json) => Product.fromJson(json)).toList();
      }
    } catch (e) {
      dev.log('API getProducts fallback: $e', name: 'ApiService');
    }
    _isOnline = false;
    return List<Product>.from(sampleProducts);
  }

  /// Fetch single product by ID, with graceful fallback to local data.
  Future<Product?> getProductById(String id) async {
    final uri = Uri.parse('$_baseUrl/api/products/$id');
    try {
      final response = await http.get(uri).timeout(_timeout);
      if (response.statusCode == 200) {
        final dynamic data = jsonDecode(response.body);
        _isOnline = true;
        return Product.fromJson(data);
      }
    } catch (e) {
      dev.log('API getProductById fallback: $e', name: 'ApiService');
    }
    _isOnline = false;
    try {
      return sampleProducts.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Search products by keyword and optional category.
  Future<List<Product>> searchProducts({
    required String query,
    String? category,
  }) async {
    final queryParams = <String, String>{};
    if (query.isNotEmpty) queryParams['query'] = query;
    if (category != null && category.isNotEmpty && category != 'All') {
      queryParams['category'] = category;
    }

    final uri = Uri.parse('$_baseUrl/api/products/search')
        .replace(queryParameters: queryParams);

    try {
      final response = await http.get(uri).timeout(_timeout);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _isOnline = true;
        return data.map((json) => Product.fromJson(json)).toList();
      }
    } catch (e) {
      dev.log('API searchProducts fallback: $e', name: 'ApiService');
    }

    _isOnline = false;
    // Local fallback search
    final cleanQuery = query.toLowerCase();
    final cleanCategory = category ?? 'All';

    return sampleProducts.where((p) {
      final matchesQuery = cleanQuery.isEmpty ||
          p.name.toLowerCase().contains(cleanQuery) ||
          p.category.toLowerCase().contains(cleanQuery) ||
          p.description.toLowerCase().contains(cleanQuery);
      final matchesCategory =
          cleanCategory == 'All' || p.category == cleanCategory;
      return matchesQuery && matchesCategory;
    }).toList();
  }

  /// Fetch categories list, with fallback to unique local categories.
  Future<List<String>> getCategories() async {
    final uri = Uri.parse('$_baseUrl/api/products/categories');
    try {
      final response = await http.get(uri).timeout(_timeout);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _isOnline = true;
        return data.map((e) => e.toString()).toList();
      }
    } catch (e) {
      dev.log('API getCategories fallback: $e', name: 'ApiService');
    }

    _isOnline = false;
    final set = sampleProducts.map((p) => p.category).toSet();
    return set.toList();
  }

  /// Process cart checkout with backend API.
  Future<Map<String, dynamic>> checkout({
    required List<CartItem> items,
    required double subtotal,
    required double shipping,
    required double total,
    String? fullName,
    String? email,
    String? address,
    String? city,
  }) async {
    final uri = Uri.parse('$_baseUrl/api/orders/checkout');

    final payload = {
      'items': items
          .map((item) => {
                'productId': item.product.id,
                'productName': item.product.name,
                'unitPrice': item.product.price,
                'quantity': item.quantity,
              })
          .toList(),
      'customer': {
        'fullName': fullName ?? 'Youssef Elsayed',
        'email': email ?? 'youssef@example.com',
        'address': address ?? '123 Nile Avenue',
        'city': city ?? 'Cairo',
      },
      'subtotal': subtotal,
      'shipping': shipping,
      'total': total,
    };

    try {
      final response = await http
          .post(
            uri,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(payload),
          )
          .timeout(_timeout);

      if (response.statusCode == 200) {
        _isOnline = true;
        return jsonDecode(response.body) as Map<String, dynamic>;
      }
    } catch (e) {
      dev.log('API checkout fallback: $e', name: 'ApiService');
    }

    _isOnline = false;
    // Local simulation fallback
    return {
      'orderId':
          'ORD-${DateTime.now().year}${(DateTime.now().millisecondsSinceEpoch % 1000000).toString().padLeft(6, '0')}',
      'success': true,
      'message': 'Order placed successfully! (Offline mode simulation)',
      'totalAmount': total,
      'itemCount': items.fold<int>(0, (sum, i) => sum + i.quantity),
    };
  }
}
