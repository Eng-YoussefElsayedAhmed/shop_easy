# 🛍️ ShopEasy — Full-Stack E-Commerce Application

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.35.3-02569B?logo=flutter&logoColor=white" />
  <img src="https://img.shields.io/badge/Dart-3.9.2-0175C2?logo=dart&logoColor=white" />
  <img src="https://img.shields.io/badge/.NET-8.0%20%7C%209.0-512BD4?logo=dotnet&logoColor=white" />
  <img src="https://img.shields.io/badge/ASP.NET%20Core-Web%20API-512BD4?logo=dotnet&logoColor=white" />
  <img src="https://img.shields.io/badge/OpenAPI-Swagger-85EA2D?logo=swagger&logoColor=black" />
  <img src="https://img.shields.io/badge/License-MIT-green" />
  <img src="https://img.shields.io/badge/Status-Production%20Ready-brightgreen" />
</p>

A **production-ready, full-stack e-commerce solution** built with an **ASP.NET Core Web API** backend and a cross-platform **Flutter** mobile/web application. Features a modern Purple/White/Light Gray design system, lightweight controller architecture with a direct repository pattern, dynamic REST API communication with graceful offline fallback, and local asset resolution.

---

## 🏛️ Full-Stack Architecture

```
                    ┌─────────────────────────────────────────┐
                    │          Flutter Client (ShopEasy)      │
                    │   Android · iOS · Web · Desktop         │
                    └──────────────────┬──────────────────────┘
                                       │
                      HTTP / REST JSON │ (Local fallback if offline)
                                       ▼
                    ┌─────────────────────────────────────────┐
                    │    ASP.NET Core Web API (ShopEasy.API)  │
                    │   .NET 8.0 / 9.0 · Swagger · CORS       │
                    └──────────────────┬──────────────────────┘
                                       │
                    ┌──────────────────┴──────────────────────┐
                    │       Direct Repository Layer           │
                    │   IProductRepository · IOrderRepository │
                    └──────────────────┬──────────────────────┘
                                       │
                    ┌──────────────────┴──────────────────────┐
                    │      Thread-Safe In-Memory Store        │
                    │   ConcurrentDictionary<string, T>       │
                    └─────────────────────────────────────────┘
```

---

## ✅ Progress Tracker

### 1. ASP.NET Core Web API Backend
- [x] Project created with clean controllers & direct repository pattern (`backend/ShopEasy.API/`)
- [x] Target Framework: `.NET 8.0` / `.NET 9.0`
- [x] CORS enabled for Flutter Web, mobile emulators (`10.0.2.2`), and desktop clients
- [x] Swagger / OpenAPI interactive documentation at root (`/`)
- [x] `GET /api/products` — Returns all store products
- [x] `GET /api/products/{id}` — Returns single product by ID (404 handled)
- [x] `GET /api/products/search?query=...&category=...` — Keyword and category search
- [x] `GET /api/products/categories` — Returns distinct product categories
- [x] `POST /api/orders/checkout` — Simulates order checkout and returns generated `orderId`
- [x] Thread-safe in-memory data store with initial sample catalog (Headphones, Smart Watch, Backpack, Sneakers, etc.)
- [x] `.http` testing file included for direct execution (`ShopEasy.API.http`)

### 2. Flutter Frontend & Asset Integration
- [x] Updated `Product` model to use `imagePath` (String) instead of remote URLs
- [x] Added `Product.fromJson()` and `Product.toJson()` for seamless REST API serialization
- [x] Local assets integrated into `assets/images/`:
  - `assets/images/headphones.png`
  - `assets/images/smartwatch.png` (and `Smart-Watch.jpg`)
  - `assets/images/backpack.png` (and `Backpack.jfif`)
  - `assets/images/sneakers.png`
  - `assets/images/Bluetooth-Speaker.jfif`
  - `assets/images/Sun-Glasses.png`
  - `assets/images/Perfume.jfif`
  - `assets/images/Coffee-Maker.jfif`
- [x] `pubspec.yaml` configured to register `assets/images/` and `http: ^1.2.0`
- [x] Created `ProductImage` reusable widget with asset loading & fallback placeholder
- [x] Created `ApiService` layer for dynamic product retrieval, category browsing, searching, and checkout simulation
- [x] Graceful fallback to local state if backend API is offline or unreachable
- [x] Updated `AppState` with reactive API data loading (`loadProducts()`) and checkout integration (`checkoutCart()`)
- [x] Pull-to-refresh (`RefreshIndicator`) on Home screen to sync with backend API

### 3. Flutter UI Screens & States
- [x] **Home Screen** — Header with cart badge, search shortcut, promo banner, category chips, popular products grid
- [x] **Product Details Screen** — Large hero asset, ratings, old/new price, feature badges, quantity selector (+/-), Add to Cart, Favorites toggle
- [x] **Favorites Screen** — My Favorites list, quick remove, Add to Cart, friendly empty state
- [x] **Shopping Cart Screen** — Item listing, quantity modifiers (+/-), delete item, live subtotal/shipping/total calculations, checkout dialog displaying API `orderId`
- [x] **Empty Cart State** — Clean illustration, "Your Cart is Empty!" notice, and "Start Shopping" button
- [x] **Search Results Screen** — Real-time keyword filter, category chips, no-results state
- [x] **Categories Screen** — Category list with item counters linked to catalog
- [x] **Profile Screen** — User summary, order history stats, account menu

---

## 📡 Backend API Endpoints

| Method | Endpoint | Description | Request Body | Response |
|---|---|---|---|---|
| `GET` | `/api/products` | Get list of all products | None | `200 OK` (Array of Product) |
| `GET` | `/api/products/{id}` | Get product details by ID | None | `200 OK` (Product) or `404 Not Found` |
| `GET` | `/api/products/search` | Search by query keyword & category | Query params: `query`, `category` | `200 OK` (Array of Product) |
| `GET` | `/api/products/categories` | Get all available categories | None | `200 OK` (Array of string) |
| `POST` | `/api/orders/checkout` | Process cart order & checkout | `CheckoutRequest` JSON | `200 OK` (`CheckoutResponse` with `orderId`) |

### Sample Checkout Request (`POST /api/orders/checkout`)
```json
{
  "items": [
    {
      "productId": "1",
      "productName": "Wireless Headphones",
      "unitPrice": 49.99,
      "quantity": 2
    }
  ],
  "customer": {
    "fullName": "Youssef Elsayed",
    "email": "youssef@example.com",
    "address": "123 Nile Avenue",
    "city": "Cairo"
  },
  "subtotal": 99.98,
  "shipping": 0.0,
  "total": 99.98
}
```

### Sample Checkout Response (`200 OK`)
```json
{
  "orderId": "ORD-20261111-1E1DEA",
  "success": true,
  "message": "Order placed successfully! Thank you for shopping with ShopEasy.",
  "orderDate": "2026-11-11T08:03:00Z",
  "totalAmount": 99.98,
  "itemCount": 2
}
```

---

## 📁 Repository Structure

```
shop_easy/
├── backend/
│   └── ShopEasy.API/                   # ASP.NET Core Web API project (.NET 8/9)
│       ├── Controllers/
│       │   ├── ProductsController.cs   # GET /api/products, search, categories
│       │   └── OrdersController.cs     # POST /api/orders/checkout
│       ├── Models/
│       │   ├── Product.cs              # Backend Product model
│       │   └── Order.cs                # CheckoutRequest, CartItemDto, CheckoutResponse
│       ├── Repositories/
│       │   ├── IProductRepository.cs
│       │   ├── ProductRepository.cs    # In-memory thread-safe store
│       │   ├── IOrderRepository.cs
│       │   └── OrderRepository.cs      # In-memory order manager
│       ├── Program.cs                  # Services, CORS, Swagger setup
│       ├── ShopEasy.API.csproj
│       └── ShopEasy.API.http           # Direct HTTP request testing file
│
├── assets/
│   └── images/                         # Local image assets
│       ├── headphones.png
│       ├── smartwatch.png
│       ├── backpack.png
│       ├── sneakers.png
│       └── ...
│
├── lib/
│   ├── main.dart                       # Flutter entry point & IndexedStack shell
│   ├── data/
│   │   ├── app_state.dart              # ChangeNotifier: cart, favorites, dynamic products
│   │   ├── app_theme.dart              # Material 3 Purple palette (#6C63FF)
│   │   └── products_data.dart          # Local fallback sample catalog
│   ├── models/
│   │   ├── product.dart                # Product model with imagePath & JSON mapping
│   │   └── cart_item.dart              # CartItem model
│   ├── services/
│   │   └── api_service.dart            # REST API client with offline fallback
│   ├── screens/
│   │   ├── home_screen.dart
│   │   ├── product_details_screen.dart
│   │   ├── favorites_screen.dart
│   │   ├── cart_screen.dart
│   │   ├── search_screen.dart
│   │   ├── categories_screen.dart
│   │   └── profile_screen.dart
│   └── widgets/
│       ├── product_card.dart
│       ├── product_image.dart          # Resilient asset/network image widget
│       └── bottom_nav_bar.dart
│
├── pubspec.yaml
└── README.md
```

---

## 🚀 Setup & Run Instructions

### 1. Prerequisites
* **.NET SDK:** 8.0 or 9.0 installed (`dotnet --version`)
* **Flutter SDK:** 3.19.0 or newer (`flutter --version`)
* **Operating System:** Windows, macOS, or Linux

---

### 2. Running the Backend API (.NET)

Open a terminal and execute:

```powershell
# Navigate to the backend project
cd "d:\Youssef Elsayed\shop_easy\backend\ShopEasy.API"

# Restore dependencies & run the API
dotnet run --urls "http://localhost:5091"
```

* **Swagger UI:** Open [http://localhost:5091](http://localhost:5091) in your browser to inspect and test all endpoints interactively.
* **API Base URL:** `http://localhost:5091/api/products`

---

### 3. Running the Frontend App (Flutter)

In a separate terminal:

```powershell
# Navigate to the Flutter project root
cd "d:\Youssef Elsayed\shop_easy"

# Ensure dependencies are fetched
flutter pub get

# Run on a connected device, emulator, or Chrome
flutter run -d chrome     # Run on Web
# or
flutter run              # Run on connected Android / iOS / Desktop
```

> [!TIP]
> **Automatic Network Routing:**
> * When running in Chrome / Desktop / iOS Simulator: `ApiService` routes to `http://localhost:5091`.
> * When running in Android Emulator: `ApiService` automatically routes to `http://10.0.2.2:5091`.
> * If the backend is not running, the Flutter app gracefully falls back to local sample data and offline simulation so the app remains 100% usable!

---

## 🧪 Quality & Tests

Run the test suite and static analysis:

```powershell
cd "d:\Youssef Elsayed\shop_easy"

# Flutter analysis (0 issues)
flutter analyze

# Flutter widget tests
flutter test

# .NET Backend Build (0 errors, 0 warnings)
cd backend\ShopEasy.API
dotnet build
```

---

## 📦 Git & GitHub Push Instructions

To stage, commit, and push the full-stack changes to your repository:

```powershell
cd "d:\Youssef Elsayed\shop_easy"

# 1. Review status
git status

# 2. Stage all full-stack changes (backend, assets, models, screens, docs)
git add .

# 3. Commit with a descriptive message
git commit -m "feat: complete full-stack expansion with ASP.NET Core Web API and Flutter integration"

# 4. Push to GitHub
git push origin main
```

---

## 📄 License

[MIT](https://choosealicense.com/licenses/mit/) © 2026 ShopEasy — Youssef Elsayed Ahmed
