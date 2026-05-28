class ProductModel {
  final String id;
  final String title;
  final String brand;
  final String image;
  final String details;
  final double price;

  final String category;
  final String? mainCategory;

  final bool isFavorite;
  final bool isInCart;
  final int quantity;

  final double rating;
  final int reviews;

  /// ✅ SIZE SYSTEM (UPDATED LOGIC)
  final List<String> sizes;
  final List<int> colors;

  const ProductModel({
    required this.id,
    required this.title,
    required this.brand,
    required this.image,
    this.details =
        "This premium fashion product is designed with high-quality materials to provide comfort, durability, and modern style. Perfect for casual wear, daily use, parties, travel, and special occasions.",
    required this.price,
    required this.category,
    this.mainCategory,
    this.isFavorite = false,
    this.isInCart = false,
    this.quantity = 1,
    this.rating = 4.5,
    this.reviews = 120,

    /// default empty → we control sizes manually per category
    this.sizes = const [],
    this.colors = const [
      0xFFF48FB1,
      0xFF90CAF9,
      0xFFA5D6A7,
    ],
  });

  /// ================= COPYWITH =================
  ProductModel copyWith({
    String? id,
    String? title,
    String? brand,
    String? image,
    String? details,
    double? price,
    String? category,
    String? mainCategory,
    bool? isFavorite,
    bool? isInCart,
    int? quantity,
    double? rating,
    int? reviews,
    List<String>? sizes,
    List<int>? colors,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      brand: brand ?? this.brand,
      image: image ?? this.image,
      details: details ?? this.details,
      price: price ?? this.price,
      category: category ?? this.category,
      mainCategory: mainCategory ?? this.mainCategory,
      isFavorite: isFavorite ?? this.isFavorite,
      isInCart: isInCart ?? this.isInCart,
      quantity: quantity ?? this.quantity,
      rating: rating ?? this.rating,
      reviews: reviews ?? this.reviews,
      sizes: sizes ?? this.sizes,
      colors: colors ?? this.colors,
    );
  }

  /// ================= JSON =================
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? "",
      title: json['title'] ?? "",
      brand: json['brand'] ?? "",
      image: json['image'] ?? "",
      details: json['details'] ?? "",
      price: (json['price'] ?? 0).toDouble(),
      category: json['category'] ?? "",
      mainCategory: json['mainCategory'],
      isFavorite: json['isFavorite'] ?? false,
      isInCart: json['isInCart'] ?? false,
      quantity: json['quantity'] ?? 1,
      rating: (json['rating'] ?? 4.5).toDouble(),
      reviews: json['reviews'] ?? 0,
      sizes: List<String>.from(json['sizes'] ?? []),
      colors: List<int>.from(json['colors'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'brand': brand,
      'image': image,
      'details': details,
      'price': price,
      'category': category,
      'mainCategory': mainCategory,
      'isFavorite': isFavorite,
      'isInCart': isInCart,
      'quantity': quantity,
      'rating': rating,
      'reviews': reviews,
      'sizes': sizes,
      'colors': colors,
    };
  }

  double get totalPrice => price * quantity;
}