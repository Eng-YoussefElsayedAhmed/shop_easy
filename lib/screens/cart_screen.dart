import 'package:flutter/material.dart';
import '../data/app_state.dart';
import '../data/app_theme.dart';
import '../widgets/product_image.dart';

class CartScreen extends StatelessWidget {
  final AppState appState;
  final VoidCallback onGoHome;

  const CartScreen({
    super.key,
    required this.appState,
    required this.onGoHome,
  });

  Future<void> _handleCheckout(BuildContext context) async {
    // Show loading indicator dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(color: AppTheme.primary),
      ),
    );

    // Call ASP.NET Core API
    final result = await appState.checkoutCart();

    if (context.mounted) {
      Navigator.of(context).pop(); // dismiss loading
      _showOrderSuccess(context, result);
    }
  }

  void _showOrderSuccess(BuildContext context, Map<String, dynamic> result) {
    final orderId = result['orderId']?.toString() ?? 'ORD-SUCCESS';
    final message = result['message'] as String? ?? 'Order placed successfully!';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8F5E9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle_rounded,
                    color: AppTheme.successGreen, size: 48),
              ),
              const SizedBox(height: 16),
              const Text(
                'Order Placed! 🎉',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.textPrimary),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.primaryLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Order ID: $orderId',
                  style: const TextStyle(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: AppTheme.textSecondary, height: 1.4),
              ),
            ],
          ),
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                appState.clearCart();
                Navigator.of(context).pop();
                onGoHome();
              },
              child: const Text('Continue Shopping'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('My Cart'),
        actions: [
          ListenableBuilder(
            listenable: appState,
            builder: (_, __) {
              if (appState.cartItems.isEmpty) {
                return const SizedBox.shrink();
              }
              return TextButton(
                onPressed: appState.clearCart,
                child: const Text('Clear All',
                    style: TextStyle(color: AppTheme.accent)),
              );
            },
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: appState,
        builder: (_, __) {
          final items = appState.cartItems;

          if (items.isEmpty) {
            return _EmptyCart(onGoHome: onGoHome);
          }

          return Column(
            children: [
              // ── Cart list ─────────────────────────────────────────
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: items.length,
                  itemBuilder: (_, i) {
                    final item = items[i];
                    final product = item.product;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: AppTheme.cardDecoration,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            // Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: ProductImage(
                                imagePath: product.imagePath,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: AppTheme.textPrimary,
                                    ),
                                    maxLines: 2,
                                    overflow:
                                        TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    product.category,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color:
                                            AppTheme.textSecondary),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                    children: [
                                      Text(
                                        '\$${item.totalPrice.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          color: AppTheme.primary,
                                          fontWeight:
                                              FontWeight.w700,
                                          fontSize: 15,
                                        ),
                                      ),
                                      // Qty controls
                                      Row(
                                        children: [
                                          _CartQtyBtn(
                                            icon: Icons.remove,
                                            onTap: () => appState
                                                .updateCartQuantity(
                                                    product.id, -1),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets
                                                    .symmetric(
                                                    horizontal: 10),
                                            child: Text(
                                              '${item.quantity}',
                                              style: const TextStyle(
                                                fontWeight:
                                                    FontWeight.w700,
                                                fontSize: 15,
                                                color: AppTheme
                                                    .textPrimary,
                                              ),
                                            ),
                                          ),
                                          _CartQtyBtn(
                                            icon: Icons.add,
                                            onTap: () => appState
                                                .updateCartQuantity(
                                                    product.id, 1),
                                            filled: true,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Delete button
                            GestureDetector(
                              onTap: () =>
                                  appState.removeFromCart(product.id),
                              child: Container(
                                margin:
                                    const EdgeInsets.only(left: 8),
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFEBEE),
                                  borderRadius:
                                      BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                    Icons.delete_outline_rounded,
                                    color: AppTheme.accent,
                                    size: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // ── Order summary ─────────────────────────────────────
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x1A000000),
                        blurRadius: 16,
                        offset: Offset(0, -4))
                  ],
                ),
                child: Column(
                  children: [
                    _SummaryRow(
                      label: 'Subtotal',
                      value:
                          '\$${appState.cartSubtotal.toStringAsFixed(2)}',
                    ),
                    const SizedBox(height: 8),
                    const _SummaryRow(
                        label: 'Shipping', value: 'FREE'),
                    const SizedBox(height: 8),
                    const Divider(color: AppTheme.divider),
                    const SizedBox(height: 8),
                    _SummaryRow(
                      label: 'Total',
                      value:
                          '\$${appState.cartTotal.toStringAsFixed(2)}',
                      isBold: true,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => _handleCheckout(context),
                        icon: const Icon(Icons.payment_rounded,
                            size: 20),
                        label: Text(
                          'Checkout  ·  \$${appState.cartTotal.toStringAsFixed(2)}',
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ── Empty Cart State ──────────────────────────────────────────────────────────
class _EmptyCart extends StatelessWidget {
  final VoidCallback onGoHome;
  const _EmptyCart({required this.onGoHome});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                color: AppTheme.primaryLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.shopping_bag_outlined,
                  size: 60, color: AppTheme.primary),
            ),
            const SizedBox(height: 24),
            const Text(
              'Your Cart is Empty!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Looks like you haven\'t added any items to your cart yet. '
              'Start shopping to fill it up!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppTheme.textSecondary, height: 1.5),
            ),
            const SizedBox(height: 28),
            ElevatedButton.icon(
              onPressed: onGoHome,
              icon: const Icon(Icons.explore_outlined),
              label: const Text('Start Shopping'),
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32, vertical: 14)),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Helper widgets ────────────────────────────────────────────────────────────
class _CartQtyBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool filled;

  const _CartQtyBtn({
    required this.icon,
    required this.onTap,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: filled ? AppTheme.primary : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: filled ? null : Border.all(color: AppTheme.divider),
        ),
        child: Icon(icon,
            size: 16,
            color: filled ? Colors.white : AppTheme.textPrimary),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isBold ? 16 : 14,
            fontWeight:
                isBold ? FontWeight.w700 : FontWeight.w400,
            color:
                isBold ? AppTheme.textPrimary : AppTheme.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 18 : 14,
            fontWeight:
                isBold ? FontWeight.w800 : FontWeight.w600,
            color: isBold ? AppTheme.primary : AppTheme.textPrimary,
          ),
        ),
      ],
    );
  }
}
