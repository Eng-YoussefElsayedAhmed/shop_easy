import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart_item.dart';
import '../data/products_data.dart';
import '../services/api_service.dart';

/// Central app-level state passed down via InheritedWidget-style provider.
class AppState extends ChangeNotifier {
  final ApiService _api = ApiService();

  // ── Products (Dynamic from API + Fallback) ─────────────────────────────────
  List<Product> _products = List<Product>.from(sampleProducts);
  bool _isLoadingProducts = false;
  String? _productsError;

  List<Product> get products => List.unmodifiable(_products);
  bool get isLoadingProducts => _isLoadingProducts;
  String? get productsError => _productsError;
  bool get isBackendConnected => _api.isOnline;

  Future<void> loadProducts() async {
    _isLoadingProducts = true;
    _productsError = null;
    notifyListeners();

    try {
      final fetched = await _api.getProducts();
      if (fetched.isNotEmpty) {
        _products = fetched;
      }
    } catch (e) {
      _productsError = e.toString();
      if (_products.isEmpty) {
        _products = List<Product>.from(sampleProducts);
      }
    } finally {
      _isLoadingProducts = false;
      notifyListeners();
    }
  }

  // ── Cart ──────────────────────────────────────────────────────────────────
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => List.unmodifiable(_cartItems);

  int get cartItemCount =>
      _cartItems.fold(0, (sum, item) => sum + item.quantity);

  double get cartSubtotal =>
      _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

  double get shipping => _cartItems.isEmpty ? 0.0 : 0.0; // free shipping

  double get cartTotal => cartSubtotal + shipping;

  void addToCart(Product product, {int quantity = 1}) {
    final existing = _cartItems.where((i) => i.product.id == product.id);
    if (existing.isNotEmpty) {
      existing.first.quantity += quantity;
    } else {
      _cartItems.add(CartItem(product: product, quantity: quantity));
    }
    notifyListeners();
  }

  void removeFromCart(String productId) {
    _cartItems.removeWhere((i) => i.product.id == productId);
    notifyListeners();
  }

  void updateCartQuantity(String productId, int delta) {
    final item = _cartItems.firstWhere((i) => i.product.id == productId,
        orElse: () => throw StateError('Product not in cart'));
    item.quantity = (item.quantity + delta).clamp(1, 99);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  bool isInCart(String productId) =>
      _cartItems.any((i) => i.product.id == productId);

  /// Submit cart checkout to backend API
  Future<Map<String, dynamic>> checkoutCart() async {
    final result = await _api.checkout(
      items: _cartItems,
      subtotal: cartSubtotal,
      shipping: shipping,
      total: cartTotal,
    );
    return result;
  }

  // ── Favorites ─────────────────────────────────────────────────────────────
  final List<Product> _favorites = [];

  List<Product> get favorites => List.unmodifiable(_favorites);

  bool isFavorite(String productId) =>
      _favorites.any((p) => p.id == productId);

  void toggleFavorite(Product product) {
    if (isFavorite(product.id)) {
      _favorites.removeWhere((p) => p.id == product.id);
    } else {
      _favorites.add(product);
    }
    notifyListeners();
  }
}
