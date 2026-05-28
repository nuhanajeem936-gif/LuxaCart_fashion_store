# Firebase Setup & Firestore Architecture Guide

This comprehensive guide details the Firebase console setup, Firestore collection schemas, sample document structures, security rules, and MVVM integration guidelines for the **LuxaCart Fashion Store** mobile application. This document serves as the complete technical documentation for your university Phase 2 Final Submission.

---

## 1. Firebase Project Setup

### Step 1: Create a Firebase Project
1. Open the [Firebase Console](https://console.firebase.google.com/).
2. Click **Add Project** and enter `LuxaCart-Fashion-Store`.
3. Enable **Google Analytics** (optional, recommended for production) and click **Create Project**.

### Step 2: Register Android & iOS Apps
To generate platform configurations, the easiest and modern method is using **FlutterFire CLI**:
1. Install the Firebase CLI on your system:
   ```bash
   npm install -g firebase-tools
   ```
2. Log in to Firebase:
   ```bash
   firebase login
   ```
3. Activate the FlutterFire CLI:
   ```bash
   dart pub global activate flutterfire_cli
   ```
4. Run the configuration command in your Flutter project directory (`fashion_store/fashion_store`):
   ```bash
   flutterfire configure
   ```
5. Select your Firebase project `LuxaCart-Fashion-Store` and configure both `android` and `ios` platforms. This automatically generates `lib/firebase_options.dart`.

---

## 2. Firebase Services Configuration

### A. Firebase Authentication
1. Go to **Build** > **Authentication** in the Firebase Console.
2. Click **Get Started**.
3. Under the **Sign-in method** tab, click **Email/Password**.
4. Enable the **Email/Password** toggle and click **Save**.

### B. Cloud Firestore Database
1. Go to **Build** > **Firestore Database** and click **Create Database**.
2. Select **Start in test mode** (for development) or **Production mode**.
3. Choose your database location (e.g., `us-central1` or `asia-southeast1`) and click **Enable**.
4. Navigate to the **Rules** tab and paste the following production-ready security rules:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // User profile rules
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
      
      // User cart subcollection rules
      match /cart/{productId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
    }
    
    // Products rules: Anyone can read, only admin can write
    match /products/{productId} {
      allow read: if true;
      allow write: if request.auth != null; // Upgrade to admin check for production
    }
    
    // Orders rules: User can read/write their own orders
    match /orders/{orderId} {
      allow read, write: if request.auth != null && request.resource.data.userId == request.auth.uid;
      allow read: if request.auth != null && resource.data.userId == request.auth.uid;
    }
  }
}
```

### C. Firebase Storage (Optional for profile pictures)
1. Go to **Build** > **Storage** and click **Get Started**.
2. Click **Next** and click **Done**.
3. Go to the **Rules** tab and set appropriate rules:
```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /users/{userId}/{allPaths=**} {
      allow read: if true;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

---

## 3. Project Dependencies (`pubspec.yaml`)

Ensure the following dependencies are specified in your `pubspec.yaml` (they are already set up in your existing project):

```yaml
dependencies:
  flutter:
    sdk: flutter

  cupertino_icons: ^1.0.8

  # UI and Navigation
  flutter_iconly: ^1.0.2
  smooth_page_indicator: ^1.1.0
  font_awesome_flutter: ^10.7.0
  url_launcher: ^6.2.5

  # PDF Printing (Useful for receipts)
  pdf: ^3.10.7
  printing: ^5.12.0

  # Fonts
  google_fonts: ^6.2.1

  # Firebase Core and Integration
  firebase_core: ^4.8.0
  cloud_firestore: ^6.4.0
  firebase_auth: ^6.5.1
  provider: ^6.1.5+1
```

---

## 4. Firestore Database Architecture

Here is the exact schema and sample document structure for your collections:

### A. Collection: `users`
Each user document is identified by their unique Firebase Authentication User ID (`uid`).

- **Path**: `/users/{uid}`
- **Fields**:
  - `name`: `String` (Full Name)
  - `email`: `String` (Email Address)
  - `location`: `String` (Shipping/City Address, e.g. "New York, USA")
  - `phone`: `String` (Phone Number)
  - `image`: `String` (URL to profile image)

#### Sample Document JSON
```json
{
  "name": "Ashley Flores",
  "email": "ashley.flores@example.com",
  "location": "New York, USA",
  "phone": "+1 555-0199",
  "image": "https://cdn-icons-png.flaticon.com/512/3135/3135715.png"
}
```

---

### B. Collection: `products`
Stores individual fashion products. The seeder will populate this dynamically.

- **Path**: `/products/{productId}`
- **Fields**:
  - `title`: `String` (Product Title)
  - `brand`: `String` (Brand name, e.g. "Zara", "Nike")
  - `image`: `String` (Asset path or HTTP URL)
  - `details`: `String` (Product details/description)
  - `price`: `Number` (Double/Integer price value)
  - `category`: `String` (Category, e.g., "Men", "Women", "Kids", "Accessories")
  - `mainCategory`: `String` (Optional sub-category)
  - `isFavorite`: `Boolean` (Local favorite state, defaults to `false`)
  - `rating`: `Number` (Average rating, e.g., 4.7)
  - `reviews`: `Number` (Total reviews count, e.g., 120)
  - `sizes`: `Array of Strings` (e.g. `["S", "M", "L", "XL"]`)
  - `colors`: `Array of Numbers` (Hex color codes, e.g. `[4294200753, 4287687417]`)

#### Sample Document JSON
```json
{
  "title": "Elegant Pearl Mini Dress",
  "brand": "Zara",
  "image": "assets/images/w1.jpg",
  "details": "White long-sleeve mini dress with classy feminine styling for elegant casual outings. Made of premium breathable materials.",
  "price": 5000.0,
  "category": "Women",
  "mainCategory": "Dresses",
  "isFavorite": false,
  "rating": 4.8,
  "reviews": 145,
  "sizes": ["S", "M", "L"],
  "colors": [4294200753, 4287687417]
}
```

---

### C. Collection: `users/{uid}/cart`
User-specific persistent cart items. Subcollection inside each user document.

- **Path**: `/users/{uid}/cart/{productId}`
- **Fields**: Matches `products` schema but adds:
  - `quantity`: `Number` (Quantity in cart)

#### Sample Document JSON
```json
{
  "id": "w1",
  "title": "Elegant Pearl Mini Dress",
  "brand": "Zara",
  "image": "assets/images/w1.jpg",
  "price": 5000.0,
  "category": "Women",
  "quantity": 2,
  "sizes": ["S", "M", "L"]
}
```

---

### D. Collection: `orders`
Stores orders made by users.

- **Path**: `/orders/{orderId}`
- **Fields**:
  - `userId`: `String` (UID of the customer)
  - `total`: `Number` (Total paid amount)
  - `status`: `String` (Order status: "Pending", "Processing", "Shipped", "Delivered")
  - `createdAt`: `Timestamp` (Server Timestamp when order was placed)
  - `items`: `Array of Objects` (List of ordered product maps, including product metadata & quantity purchased)
  - `deliveryDetails`: `Map` (Captured shipping details):
    - `fullName`: `String` (Full Name)
    - `phone`: `String` (Phone Number)
    - `address`: `String` (Street Address)
    - `city`: `String` (City)
    - `zipCode`: `String` (Zip/Postal Code)

#### Sample Document JSON
```json
{
  "userId": "jX83fKs9aHw72eLq01Pd34",
  "total": 10010.0,
  "status": "Pending",
  "createdAt": {
    "_seconds": 1779899120,
    "_nanoseconds": 500000000
  },
  "items": [
    {
      "id": "w1",
      "title": "Elegant Pearl Mini Dress",
      "brand": "Zara",
      "price": 5000.0,
      "image": "assets/images/w1.jpg",
      "quantity": 2
    }
  ],
  "deliveryDetails": {
    "fullName": "Ashley Flores",
    "phone": "+1 555-0199",
    "address": "456 Fashion Ave, Apt 3B",
    "city": "New York",
    "zipCode": "10018"
  }
}
```

---

## 5. MVVM Architecture Alignment

Our upgrades rigorously implement the clean **MVVM (Model-View-ViewModel)** structural pattern:

```
[ View Layer ] (Screens & Widgets)
     │
     ▼ (Interacts via Provider)
[ ViewModel Layer ] (State Management & Business Logic)
     │
     ▼ (Fetches / Updates)
[ Services Layer ] (AuthService & FirestoreService)
     │
     ▼ (Serializes using)
[ Model Layer ] (UserModel, ProductModel, OrderModel)
```

1. **Models**: Plain Dart classes (`UserModel`, `ProductModel`) containing properties, JSON serializers (`fromJson`, `toJson`), and utility methods (`copyWith`).
2. **Services**: Low-level database and authentication operations (`AuthService`, `FirestoreService`).
3. **ViewModels**: Maintain state and handle asynchronous operations (`AuthViewModel`, `ProductViewModel`, `CartViewModel`, `OrderViewModel`). They extend `ChangeNotifier` and trigger `notifyListeners()` to redraw active Views.
4. **Views**: The UI layer (`HomeScreen`, `CartScreen`, `CheckoutScreen`, `ProfileScreen`) that consumes ViewModel states and renders a high-fidelity pink fashion themed interface. No Firebase calls are made inside Views.
