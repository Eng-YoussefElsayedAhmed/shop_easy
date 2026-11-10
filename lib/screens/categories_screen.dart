import 'package:flutter/material.dart';
import '../data/app_state.dart';
import '../data/app_theme.dart';
import '../data/products_data.dart';

class CategoriesScreen extends StatefulWidget {
  final AppState appState;
  final ValueChanged<int> onNavTap;

  const CategoriesScreen({
    super.key,
    required this.appState,
    required this.onNavTap,
  });

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  static const _categoryData = [
    {'name': 'Electronics', 'icon': Icons.headphones_rounded, 'color': 0xFF6C63FF},
    {'name': 'Fashion', 'icon': Icons.checkroom_rounded, 'color': 0xFFFF6584},
    {'name': 'Home & Living', 'icon': Icons.weekend_rounded, 'color': 0xFF4CAF50},
    {'name': 'Beauty', 'icon': Icons.spa_rounded, 'color': 0xFFFFC107},
    {'name': 'Bags', 'icon': Icons.backpack_rounded, 'color': 0xFF00BCD4},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(title: const Text('Categories')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: _categoryData.map((cat) {
          final name = cat['name'] as String;
          final icon = cat['icon'] as IconData;
          final color = Color(cat['color'] as int);
          final count = sampleProducts
              .where((p) => p.category == name)
              .length;

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: AppTheme.cardDecoration,
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              title: Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: AppTheme.textPrimary,
                ),
              ),
              subtitle: Text(
                '$count products',
                style: const TextStyle(
                    color: AppTheme.textSecondary, fontSize: 13),
              ),
              trailing: const Icon(Icons.chevron_right_rounded,
                  color: AppTheme.textSecondary),
              onTap: () => widget.onNavTap(0),
            ),
          );
        }).toList(),
      ),
    );
  }
}
