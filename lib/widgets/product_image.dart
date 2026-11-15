import 'package:flutter/material.dart';
import '../data/app_theme.dart';

class ProductImage extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit fit;

  const ProductImage({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    final cleanPath = imagePath.trim();

    if (cleanPath.startsWith('http://') || cleanPath.startsWith('https://')) {
      return Image.network(
        cleanPath,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          final totalBytes = loadingProgress.expectedTotalBytes;
          final downloaded = loadingProgress.cumulativeBytesLoaded;
          return Container(
            width: width,
            height: height,
            color: AppTheme.primaryLight,
            child: Center(
              child: SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(
                  value: totalBytes != null && totalBytes > 0
                      ? downloaded / totalBytes
                      : null,
                  strokeWidth: 2.5,
                  color: AppTheme.primary,
                ),
              ),
            ),
          );
        },
        errorBuilder: (_, __, ___) => _errorPlaceholder(),
      );
    }

    // Local asset support
    return Image.asset(
      cleanPath,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (_, __, ___) => _errorPlaceholder(),
    );
  }

  Widget _errorPlaceholder() {
    return Container(
      width: width,
      height: height,
      color: AppTheme.primaryLight,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              color: AppTheme.primary,
              size: 32,
            ),
            SizedBox(height: 4),
            Text(
              'ShopEasy',
              style: TextStyle(
                color: AppTheme.primary,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
