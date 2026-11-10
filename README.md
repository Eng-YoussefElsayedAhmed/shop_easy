# 🛍️ ShopEasy — Flutter E-Commerce App

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.35.3-02569B?logo=flutter&logoColor=white" />
  <img src="https://img.shields.io/badge/Dart-3.9.2-0175C2?logo=dart&logoColor=white" />
  <img src="https://img.shields.io/badge/License-MIT-green" />
  <img src="https://img.shields.io/badge/Status-Production%20Ready-brightgreen" />
</p>

A **production-ready** Flutter mobile e-commerce application featuring a clean, modern UI with a Purple / White / Light Gray theme. ShopEasy demonstrates real-world Flutter architecture patterns including shared state management with `ChangeNotifier`, reactive UI with `ListenableBuilder`, and clean separation of concerns via a well-organized folder structure.

---

## ✅ Progress Tracker

### Architecture & Setup
- [x] Flutter project scaffolded (null-safe, Material 3)
- [x] Clean folder structure: `models/`, `data/`, `screens/`, `widgets/`
- [x] Centralized `AppState` (ChangeNotifier) for cart & favorites
- [x] Centralized `AppTheme` with consistent design tokens
- [x] `flutter analyze` — **No issues found**
- [x] Git repository initialized with initial commit

### Models
- [x] `Product` model — id, name, category, price, oldPrice, rating, reviews, description, features, imageUrl, discountPercent
- [x] `CartItem` model — product reference, quantity, totalPrice getter

### Data Layer
- [x] `products_data.dart` — 8 sample products across 5 categories
- [x] `app_state.dart` — unified cart + favorites reactive state
- [x] `app_theme.dart` — full Material 3 theme with palette, components, decorations

### Screens
- [x] **Home Screen** — Greeting, search bar (navigates to Search), promo banner, category chips, products grid
- [x] **Product Details Screen** — Large image, rating stars, price/discount, description, feature badges, quantity selector, Add-to-Cart, heart toggle
- [x] **Favorites Screen** — My Favorites list, remove/add-to-cart actions, empty state
- [x] **Cart Screen** — Cart items with qty controls, real-time subtotal/shipping/total, Checkout dialog, empty cart state
- [x] **Search Screen** — Live search, category filter chips, results grid, No Results message
- [x] **Categories Screen** — Categorized browse list with counts
- [x] **Profile Screen** — Profile header, stats, menu items (placeholder)

### Widgets
- [x] `ProductCard` — image, discount badge, favorite toggle, quick-add, price display
- [x] `AppBottomNavBar` — 5-tab nav with live cart count badge
- [x] `CartBadge` — AppBar cart icon with live count

### Features
- [x] Cart: add, increment, decrement, delete, clear, real-time total
- [x] Favorites: toggle, remove, add-to-cart from list
- [x] Search: case-insensitive by name/category, filter by category
- [x] Product Details: quantity selector (min 1), Add-to-Cart snackbar, existing-product increment
- [x] Order Success dialog with "Continue Shopping" action
- [x] Empty Cart state with "Start Shopping" CTA
- [x] Empty Favorites state
- [x] Image loading/error states on all cards
- [x] IndexedStack-based shell navigation (preserves scroll state per tab)

---

## 📁 Folder Structure

```
shop_easy/
├── lib/
│   ├── main.dart                   # App entry point & shell navigator
│   ├── data/
│   │   ├── app_state.dart          # ChangeNotifier: cart + favorites
│   │   ├── app_theme.dart          # Theme, colors, decorations
│   │   └── products_data.dart      # Sample product list (8 products)
│   ├── models/
│   │   ├── product.dart            # Product data class
│   │   └── cart_item.dart          # CartItem data class
│   ├── screens/
│   │   ├── home_screen.dart        # Home tab
│   │   ├── product_details_screen.dart
│   │   ├── favorites_screen.dart   # Favorites tab
│   │   ├── cart_screen.dart        # Cart tab
│   │   ├── search_screen.dart      # Navigated from search bar
│   │   ├── categories_screen.dart  # Categories tab
│   │   └── profile_screen.dart     # Profile tab
│   └── widgets/
│       ├── product_card.dart       # Reusable product grid card
│       └── bottom_nav_bar.dart     # App-wide bottom nav + cart badge
├── test/
│   └── widget_test.dart            # Smoke test
├── pubspec.yaml
└── README.md
```

---

## 🎨 Design System

| Token | Value |
|---|---|
| Primary | `#6C63FF` (Purple) |
| Accent | `#FF6584` (Coral/Pink) |
| Background | `#F8F8FC` (Light Gray) |
| Surface | `#FFFFFF` (White) |
| Text Primary | `#1A1A2E` |
| Text Secondary | `#6B7280` |
| Star Color | `#FFC107` |
| Success | `#4CAF50` |

---

## 🚀 Getting Started

### Prerequisites

| Tool | Required Version |
|---|---|
| Flutter SDK | >= 3.19.0 |
| Dart | >= 3.3.0 |
| Android Studio / Xcode | Latest stable |

### Run Locally

```bash
# 1. Navigate into the project directory
cd shop_easy

# 2. Install dependencies
flutter pub get

# 3. Run on a connected device or emulator
flutter run

# 4. Run static analysis
flutter analyze

# 5. Run tests
flutter test
```

### Build for Release

```bash
# Android APK
flutter build apk --release

# iOS (macOS only)
flutter build ios --release

# Android App Bundle (Play Store)
flutter build appbundle --release
```

---

## 🧪 Sample Products

| # | Name | Category | Price | Old Price | Discount |
|---|------|----------|-------|-----------|----------|
| 1 | Wireless Headphones | Electronics | $49.99 | $79.99 | 38% |
| 2 | Smart Watch | Electronics | $79.99 | $129.99 | 38% |
| 3 | Backpack | Bags | $29.99 | $49.99 | 40% |
| 4 | Sneakers | Fashion | $59.99 | $89.99 | 33% |
| 5 | Bluetooth Speaker | Electronics | $39.99 | $59.99 | 33% |
| 6 | Sunglasses | Fashion | $24.99 | $39.99 | 37% |
| 7 | Perfume | Beauty | $44.99 | $69.99 | 36% |
| 8 | Coffee Maker | Home & Living | $54.99 | $84.99 | 35% |

---

## Architecture

```
main.dart (AppShell)
|
+-- AppState (ChangeNotifier)       <- Shared singleton for cart & favorites
|   +-- cartItems: List<CartItem>
|   +-- favorites: List<Product>
|
+-- IndexedStack Navigation
    +-- [0] HomeScreen
    +-- [1] CategoriesScreen
    +-- [2] FavoritesScreen
    +-- [3] CartScreen
    +-- [4] ProfileScreen
```

State flows **down** via constructor injection. The `ListenableBuilder` widget subscribes to `AppState` and rebuilds only the parts of the UI that depend on changing data (cart count badge, favorite icons, cart totals). No third-party state management libraries are required.

---

## Contributing

Pull requests are welcome. For major changes, please open an issue first.

---

## License

MIT (c) 2026 ShopEasy
