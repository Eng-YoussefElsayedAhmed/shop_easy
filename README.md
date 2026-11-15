# 🛍️ ShopEasy — Flutter Mobile E-Commerce Application

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.35.3-02569B?logo=flutter&logoColor=white" />
  <img src="https://img.shields.io/badge/Dart-3.9.2-0175C2?logo=dart&logoColor=white" />
  <img src="https://img.shields.io/badge/Live%20API-HTTPS%20REST-00C853?logo=fastapi&logoColor=white" />
  <img src="https://img.shields.io/badge/State-ChangeNotifier-6C63FF" />
  <img src="https://img.shields.io/badge/License-MIT-green" />
  <img src="https://img.shields.io/badge/Status-Production%20Ready-brightgreen" />
</p>

A **production-ready** Flutter mobile e-commerce application built with a modern Purple (`#6C63FF`), White, and Light Gray visual identity. ShopEasy integrates dynamically with a **live REST backend API** to fetch product catalog data, handles local self-signed HTTPS certificate verification gracefully, and provides a seamless shopping experience with favorites, cart management, search filtering, and responsive UI states.

---

## 🌐 Live API Integration

ShopEasy connects directly to our live backend API endpoint:
* **Endpoint URL:** `https://192.168.21.240:5001/api/products`
* **Transport:** HTTPS with self-signed SSL certificate handling
* **Certificate Handling:** Configured via custom `HttpOverrides` (`setupHttpOverrides()`) and a custom `HttpClient` (`IOClient`) with `badCertificateCallback = (cert, host, port) => true`. Both network requests and `Image.network` asset downloads proceed without SSL handshake failures.
* **Resilient Offline Fallback:** If the local API server is unreachable, the app seamlessly falls back to pre-configured local state so the interface remains fully interactive and error-free.

### API Data Contract
The application consumes products formatted according to the exact JSON schema:
```json
[
  {
    "id": 1,
    "title": "iphone",
    "price": 50000,
    "description": "very expensive",
    "imgUrl": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlp_4-bDtt12hdJAKC7DDo5ubySY_Oj-1ulA&s"
  },
  {
    "id": 2,
    "title": "Wireless Noise-Canceling Headphones",
    "price": 299.99,
    "description": "Premium over-ear headphones with 30-hour battery life.",
    "imgUrl": "https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcSna2PaQLao22IK4nBbTJFWrjo9PcTauDnnhhXipeDbl1r50zGCe_5Pxfqp9j42UyH0PJwLBvxH3ziWP3_TOATJzRQgudLQrvri6q-GssAdigO8YMAn88g3_jJhlX6zS1Bv1Vw8ddM&usqp=CAc"
  },
  {
    "id": 3,
    "title": "Mechanical Gaming Keyboard",
    "price": 129.5,
    "description": "RGB backlit keys with tactile switches for pro gaming.",
    "imgUrl": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSeUS50YVZ6wM9OMu07fITBQP5FcjUe5sa9nQ&s"
  },
  {
    "id": 4,
    "title": "Smart Fitness Tracker",
    "price": 79,
    "description": "Monitors heart rate, sleep patterns, and daily steps.",
    "imgUrl": "https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcQGjfdcfz931PBZI-d_Ou5wHRl8Ciz5fjyaYiveFe3lNNgZtk7C5iLY1XYuuuOFd-gfRmN4F01MYdoe955nG6XrtDnfkOlkz37zFjxAUeykRlJWs_iNsrRHV8C508cORUbxg0qR4nc&usqp=CAc"
  },
  {
    "id": 5,
    "title": "Ultra-Wide 4K Monitor",
    "price": 450,
    "description": "34-inch curved display perfect for multitasking and design.",
    "imgUrl": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjt_rLDTZUxwD4aVgDmnTnJiBMGkN7V0imXA&s"
  },
  {
    "id": 6,
    "title": "Portable Power Bank",
    "price": 45.99,
    "description": "20,000mAh capacity with fast charging support.",
    "imgUrl": "https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcQsld8ozcQNl45uM1vJJ8Gbnc3KosH9a9BzAy8kNOYwY1H9wt0gXTUvLgKmmuqVdV9rx6gN3-lcascrX3o7_D3wrPFdxxEzaYUa1-bAfP4XrK60nf5D7eAxuk81rMTA3sjTYfA7NiY&usqp=CAc"
  }
]
```

---

## ✅ Progress Tracker

### 1. Live API Integration & Networking
- [x] Removed all legacy/mock backend directories to depend exclusively on the live endpoint.
- [x] Configured `ApiService` to connect to `https://192.168.21.240:5001/api/products`.
- [x] Implemented SSL certificate override with `HttpOverrides.global` and `custom_http_client` to bypass self-signed certificate restrictions.
- [x] Robust numeric parsing: `(json['price'] as num).toDouble()` handles both integers (e.g. `50000`, `79`) and decimals (`299.99`, `129.5`).
- [x] URL sanitization in `Product.fromJson` cleans both raw URLs and markdown-formatted links.
- [x] `ProductImage` widget displays remote images via `Image.network` with smooth progress indicators and fallback error placeholders.

### 2. State Management & Data Layer
- [x] `AppState` (`ChangeNotifier`) manages products, shopping cart, and favorites globally.
- [x] Automatic asynchronous data loading via `AppState.loadProducts()` on application startup.
- [x] Pull-to-refresh (`RefreshIndicator`) on Home screen to fetch the latest catalog from the live API.
- [x] Cart operations: add, increment, decrement, delete, clear, and real-time total recalculation.
- [x] Favorites operations: toggle favorite, remove, and add directly to cart.

### 3. Screen Implementations & UI States
- [x] **Home Screen:**
  - Header with ShopEasy brand identity and live item count badge on Cart icon.
  - Interactive search bar with shortcut navigation to Search screen.
  - Promotional gradient banner ("Special Offer - Up to 50% OFF").
  - Dynamic horizontal category filter chips.
  - Live products grid using `GridView.builder` and responsive `ProductCard` components.
  - 5-tab Bottom Navigation Bar (Home, Categories, Favorites, Cart, Profile).
- [x] **Product Details Screen:**
  - Full-width hero image with gradient overlay.
  - Product title, star rating, review count, price, and discount calculations.
  - Product description and feature highlight badges.
  - Interactive quantity selector with minimum threshold of 1.
  - "Add to Cart" button with animated confirmation feedback.
  - Heart icon to toggle favorites state.
- [x] **Favorites Screen ("My Favorites"):**
  - Saved products list using `ListView.builder`.
  - One-tap removal or direct transfer to cart.
  - Empty state with illustration and "Explore Products" button.
- [x] **Shopping Cart Screen & Empty Cart State:**
  - Item listing with thumbnail, title, unit price, and live quantity modifiers (+ / - / delete).
  - Real-time automatic calculation of Subtotal, Shipping (Free), and Total.
  - Checkout action presenting order confirmation with generated order identifier.
  - **Empty Cart State:** Displayed automatically when cart is empty with "Your Cart is Empty!" illustration and "Start Shopping" button.
- [x] **Search Results Screen:**
  - Search input with clear button.
  - Category filter pills (All, Electronics, Fashion, etc.).
  - Case-insensitive search across title, description, and category.
  - "No Results Found" view when queries match no items.
- [x] **Categories Screen:**
  - Visual category listing with icons, color coding, and live product counters.
- [x] **Profile Screen:**
  - User avatar, membership status, order statistics, and account navigation items.

---

## 📁 Project Architecture & Folder Structure

```
shop_easy/
├── assets/
│   └── images/                         # Local asset fallbacks
├── lib/
│   ├── main.dart                       # App entry point, SSL initialization, IndexedStack shell
│   ├── data/
│   │   ├── app_state.dart              # Central ChangeNotifier (Cart, Favorites, Live Products)
│   │   ├── app_theme.dart              # Material 3 Purple palette (#6C63FF) & component styles
│   │   └── products_data.dart          # Local fallback data matching live API schema
│   ├── models/
│   │   ├── cart_item.dart              # CartItem data model
│   │   └── product.dart                # Product model with live JSON serialization & URL cleaning
│   ├── screens/
│   │   ├── cart_screen.dart            # Cart management & empty cart state
│   │   ├── categories_screen.dart      # Category browser with live product counts
│   │   ├── favorites_screen.dart       # Wishlist screen with empty state
│   │   ├── home_screen.dart            # Main store feed with pull-to-refresh
│   │   ├── product_details_screen.dart # Detailed product view & quantity selector
│   │   ├── profile_screen.dart         # User profile placeholder
│   │   └── search_screen.dart          # Live keyword search & category filter
│   ├── services/
│   │   ├── api_service.dart            # Live REST client (https://192.168.21.240:5001)
│   │   ├── custom_http_client.dart     # Conditional import for SSL client
│   │   ├── custom_http_client_vm.dart  # Dart IO client with badCertificateCallback
│   │   ├── custom_http_client_web.dart # Web HTTP client adapter
│   │   ├── http_overrides.dart         # Conditional export for global SSL overrides
│   │   ├── http_overrides_vm.dart      # Global HttpOverrides for mobile/desktop
│   │   └── http_overrides_web.dart     # Web no-op SSL overrides
│   └── widgets/
│       ├── bottom_nav_bar.dart         # Shared bottom navigation with cart badge
│       ├── product_card.dart           # Reusable product grid card
│       └── product_image.dart          # Image.network with loading & error placeholders
├── test/
│   ├── product_model_test.dart         # Unit tests validating live API JSON parsing
│   └── widget_test.dart                # Flutter smoke test
├── pubspec.yaml
└── README.md
```

---

## 🎨 Design System

| Token | Hex Value | Usage |
|---|---|---|
| **Primary** | `#6C63FF` | Buttons, active icons, brand accents |
| **Primary Light** | `#EEEDFF` | Chips, badges, placeholder backgrounds |
| **Accent / Secondary** | `#FF6584` | Favorite hearts, discount tags |
| **Background** | `#F8F8FC` | Scaffold and screen background |
| **Surface / Card** | `#FFFFFF` | Rounded cards, app bars, dialogs |
| **Text Primary** | `#1A1A2E` | Product titles, headers, totals |
| **Text Secondary** | `#6B7280` | Subtitles, reviews, metadata |
| **Star Rating** | `#FFC107` | Review stars |
| **Success** | `#4CAF50` | Checkout success badges |

---

## 🚀 Setup & Execution Guide

### Prerequisites
* Flutter SDK (3.19.0 or newer)
* Dart SDK (3.3.0 or newer)
* An active network connection to reach `https://192.168.21.240:5001` (or local fallback will be used)

### Run the App Locally

```powershell
# 1. Navigate to the project root
cd "d:\Youssef Elsayed\shop_easy"

# 2. Fetch dependencies
flutter pub get

# 3. Verify static analysis (0 issues)
flutter analyze

# 4. Run automated test suites (2 passing test suites)
flutter test

# 5. Launch the application
flutter run
```

---

## 📦 Git & GitHub Push Instructions

To stage, commit, and push all updates to your GitHub repository:

```powershell
cd "d:\Youssef Elsayed\shop_easy"

# 1. Check working directory status
git status

# 2. Stage all modified and added files
git add .

# 3. Commit with a clear descriptive message
git commit -m "feat: connect ShopEasy directly to live backend API with self-signed SSL support and clean model integration"

# 4. Push to your GitHub repository
git push origin main
```

---

## 📄 License

[MIT](https://choosealicense.com/licenses/mit/) © 2026 ShopEasy — Youssef Elsayed Ahmed
