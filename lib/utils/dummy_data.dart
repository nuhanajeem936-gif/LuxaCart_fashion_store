import '../models/product_model.dart';

/// ===============================
/// FAVORITES
/// ===============================
List<ProductModel> favoriteItems = [];

/// ===============================
/// CART ITEMS
/// ===============================
List<ProductModel> itemsInCart = [];

/// ===============================
/// SAMPLE PRODUCTS
/// ===============================
List<ProductModel> dummyProducts = [
  ProductModel(
    id: "1",
    title: "Pink Hoodie",
    brand: "Zara", // ✅ ADDED
    category: "Women",
    price: 2999,
    image: "assets/images/w1.jpg",
    details: "Premium quality pink hoodie for women.",
    rating: 4.8,
  ),

  ProductModel(
    id: "2",
    title: "Casual T-Shirt",
    brand: "Nike", // ✅ ADDED
    category: "Men",
    price: 1999,
    image: "assets/images/m1.jpg",
    details: "Comfortable cotton casual t-shirt.",
    rating: 4.5,
  ),

  ProductModel(
    id: "3",
    title: "Elegant Dress",
    brand: "Gucci", // ✅ ADDED
    category: "Women",
    price: 4599,
    image: "assets/images/w2.jpg",
    details: "Stylish elegant dress for special occasions.",
    rating: 4.9,
  ),

  ProductModel(
    id: "4",
    title: "Black Jacket",
    brand: "H&M", // ✅ ADDED
    category: "Men",
    price: 5999,
    image: "assets/images/m2.jpg",
    details: "Modern black jacket with premium finish.",
    rating: 4.7,
  ),
];

/// ===============================
/// CART TOTAL
/// ===============================
double getCartTotal() {
  double total = 0;

  for (var item in itemsInCart) {
    total += item.totalPrice;
  }

  return total;
}

/// ===============================
/// SHIPPING FEE
/// ===============================
double getShippingFee() {
  return 214.0;
}

/// ===============================
/// FINAL TOTAL
/// ===============================
double getFinalTotal() {
  return getCartTotal() + getShippingFee();
}