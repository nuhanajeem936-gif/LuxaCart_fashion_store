import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/product_model.dart';
import '../models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// =========================
  /// PRODUCTS
  /// =========================
  Stream<List<ProductModel>> getProducts() {
    return _firestore.collection('products').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return ProductModel.fromJson(data);
      }).toList();
    });
  }

  Future<void> updateProduct(ProductModel product) async {
    await _firestore
        .collection('products')
        .doc(product.id)
        .update(product.toJson());
  }

  /// =========================
  /// USER PROFILE
  /// =========================
  Future<UserModel?> getUserProfile() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return null;

    final doc = await _firestore.collection('users').doc(uid).get();

    if (!doc.exists) return null;

    return UserModel.fromJson(doc.data() as Map<String, dynamic>);
  }

  Future<void> updateUserProfile(UserModel user) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    await _firestore
        .collection('users')
        .doc(uid)
        .set(user.toJson(), SetOptions(merge: true));
  }


  /// =========================
  /// CART (USER BASED)
  /// =========================
  Stream<List<ProductModel>> getCart() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return const Stream.empty();

    return _firestore
        .collection('users')
        .doc(uid)
        .collection('cart')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return ProductModel.fromJson(data);
      }).toList();
    });
  }

  Future<void> addToCart(ProductModel product) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('cart')
        .doc(product.id)
        .set(product.toJson(), SetOptions(merge: true));
  }

  Future<void> removeFromCart(String productId) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('cart')
        .doc(productId)
        .delete();
  }

  /// =========================
  /// ORDERS
  /// =========================
  Future<void> placeOrder(
      List<ProductModel> items, double total, Map<String, dynamic> deliveryDetails) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    await _firestore.collection('orders').add({
      'userId': uid,
      'items': items.map((e) => e.toJson()).toList(),
      'total': total,
      'status': 'Pending',
      'createdAt': FieldValue.serverTimestamp(),
      'deliveryDetails': deliveryDetails,
    });

    final cartRef = _firestore
        .collection('users')
        .doc(uid)
        .collection('cart');

    final snapshot = await cartRef.get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  Stream<List<Map<String, dynamic>>> getOrders() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return const Stream.empty();

    return _firestore
        .collection('orders')
        .where('userId', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    });
  }

  /// =========================
  /// PRODUCT DATABASE SEEDER
  /// =========================
  Future<void> seedSampleProducts() async {
    final productsCollection = _firestore.collection('products');
    final snapshot = await productsCollection.limit(1).get();
    
    // Only seed if the products collection is completely empty
    if (snapshot.docs.isNotEmpty) return;

    final List<Map<String, dynamic>> sampleProducts = [
      // MEN
      {
        'title': 'Grey Casual Tracksuit',
        'brand': 'UrbanFlex',
        'price': 7500.0,
        'image': 'assets/images/m1.jpg',
        'category': 'Men',
        'details': 'Comfortable grey tracksuit perfect for casual wear and street style. Premium breathable cotton blend.',
        'rating': 4.7,
        'reviews': 95,
        'sizes': ['S', 'M', 'L', 'XL'],
        'colors': [0xFF90CAF9, 0xFFB0BEC5],
        'isFavorite': false,
      },
      {
        'title': 'Classic Brown Shirt Outfit',
        'brand': 'Zentro',
        'price': 4500.0,
        'image': 'assets/images/m2.jpg',
        'category': 'Men',
        'details': 'Stylish brown shirt with black pants for a smart-casual look. Lightweight and versatile.',
        'rating': 4.5,
        'reviews': 80,
        'sizes': ['M', 'L', 'XL'],
        'colors': [0xFF8D6E63, 0xFF212121],
        'isFavorite': false,
      },
      // WOMEN
      {
        'title': 'Elegant Pearl Mini Dress',
        'brand': 'Zara',
        'price': 5000.0,
        'image': 'assets/images/w1.jpg',
        'category': 'Women',
        'details': 'White long-sleeve mini dress with classy feminine styling for elegant casual outings and premium dress feel.',
        'rating': 4.8,
        'reviews': 120,
        'sizes': ['S', 'M', 'L'],
        'colors': [0xFFFFFFFF, 0xFFF8BBD0],
        'isFavorite': false,
      },
      {
        'title': 'Blossom Grace Maxi Dress',
        'brand': 'Dior',
        'price': 7000.0,
        'image': 'assets/images/w2.jpg',
        'category': 'Women',
        'details': 'Soft pink floral maxi dress with flowy silhouette and romantic summer vibes. Made from silk chiffon.',
        'rating': 4.9,
        'reviews': 65,
        'sizes': ['S', 'M', 'L', 'XL'],
        'colors': [0xFFF48FB1, 0xFFFCE4EC],
        'isFavorite': false,
      },
      // UNISEX
      {
        'title': 'Puzzle Heart Couple Hoodie',
        'brand': 'CozyBond',
        'price': 3500.0,
        'image': 'assets/images/ux1.jpg',
        'category': 'Unisex',
        'details': 'Cute matching puzzle heart couple hoodie. Perfect for matching street style, warm, soft, and cozy.',
        'rating': 4.6,
        'reviews': 110,
        'sizes': ['S', 'M', 'L', 'XL'],
        'colors': [0xFF000000, 0xFFECEFF1],
        'isFavorite': false,
      },
      {
        'title': 'Oversized Pastel Sweater',
        'brand': 'Aether',
        'price': 6000.0,
        'image': 'assets/images/ux2.jpg',
        'category': 'Unisex',
        'details': 'Oversized premium knit sweater in lovely pastel gradients. Unisex fit, thick warmth, and gorgeous look.',
        'rating': 4.7,
        'reviews': 45,
        'sizes': ['M', 'L'],
        'colors': [0xFFE1BEE7, 0xFFB3E5FC],
        'isFavorite': false,
      },
      // KIDS
      {
        'title': 'Princess Bloom Party Dress',
        'brand': 'Little Fairy',
        'price': 8500.0,
        'image': 'assets/images/k1.jpg',
        'category': 'Kids',
        'details': 'Elegant pink layered tulle dress for girls, perfect for birthdays, weddings, and special events. Soft satin inner lining.',
        'rating': 4.9,
        'reviews': 54,
        'sizes': ['XS', 'S', 'M'],
        'colors': [0xFFF8BBD0, 0xFFFFF9C4],
        'isFavorite': false,
      },
      {
        'title': 'Urban Breeze Boys Set',
        'brand': 'MiniTrendz',
        'price': 6000.0,
        'image': 'assets/images/k2.jpg',
        'category': 'Kids',
        'details': 'Stylish boys summer outfit with a light blue shirt and matching shorts. Breathable linen blend.',
        'rating': 4.5,
        'reviews': 32,
        'sizes': ['S', 'M', 'L'],
        'colors': [0xFFB3E5FC, 0xFFCFD8DC],
        'isFavorite': false,
      },
      // BAGS
      {
        'title': 'Cute Bunny School Backpack',
        'brand': 'Pinky Bags',
        'price': 3000.0,
        'image': 'assets/images/B1.jpg',
        'category': 'Bags',
        'details': 'Spacious pastel pink backpack with bunny ears and soft plush keychain. Perfect for school and daily use.',
        'rating': 4.8,
        'reviews': 85,
        'sizes': ['One Size'],
        'colors': [0xFFF8BBD0],
        'isFavorite': false,
      },
      {
        'title': 'Elegant Leather Handbag',
        'brand': 'Luxe Carry',
        'price': 6000.0,
        'image': 'assets/images/B2.jpg',
        'category': 'Bags',
        'details': 'Stylish maroon leather handbag with gold chain details, designed for modern casual and formal fashion.',
        'rating': 4.6,
        'reviews': 72,
        'sizes': ['One Size'],
        'colors': [0xFF880E4F],
        'isFavorite': false,
      },
      // COSMETICS
      {
        'title': 'Velvet Matte Lipstick Set',
        'brand': 'Glam Beauty',
        'price': 3500.0,
        'image': 'assets/images/cos1.jpg',
        'category': 'Cosmetics',
        'details': 'Collection of rich matte lipsticks with smooth texture and long-lasting color for daily and party makeup.',
        'rating': 4.7,
        'reviews': 104,
        'sizes': ['Standard'],
        'colors': [0xFFD81B60, 0xFFE91E63],
        'isFavorite': false,
      },
      {
        'title': 'Desire Luxury Perfume',
        'brand': 'Royal Essence',
        'price': 6000.0,
        'image': 'assets/images/cos2.jpg',
        'category': 'Cosmetics',
        'details': 'Elegant fragrance perfume with a bold and sophisticated scent, suitable for special occasions.',
        'rating': 4.8,
        'reviews': 50,
        'sizes': ['50ml', '100ml'],
        'colors': [0xFFFCE4EC],
        'isFavorite': false,
      },
      // ACCESSORIES
      {
        'title': 'Elegant Bow Hair Clips',
        'brand': 'Veloura',
        'price': 1000.0,
        'image': 'assets/images/a1.jpg',
        'category': 'Accessories',
        'details': 'Soft satin ribbon bow clips designed for elegant hairstyles and modern feminine fashion accent.',
        'rating': 4.5,
        'reviews': 40,
        'sizes': ['One Size'],
        'colors': [0xFFF48FB1, 0xFFFFFFFF],
        'isFavorite': false,
      },
      {
        'title': 'Matte Black Sunglasses',
        'brand': 'UrbanRay',
        'price': 3000.0,
        'image': 'assets/images/a2.jpg',
        'category': 'Accessories',
        'details': 'Trendy square-frame sunglasses with premium UV-protected lenses for daily wear.',
        'rating': 4.6,
        'reviews': 90,
        'sizes': ['One Size'],
        'colors': [0xFF000000],
        'isFavorite': false,
      },
      // FOOTWEAR
      {
        'title': 'Vibrant Comfort Sneakers',
        'brand': 'Nike',
        'price': 5000.0,
        'image': 'assets/images/f1.jpg',
        'category': 'Footwear',
        'details': 'Premium styling sneakers for ultimate walking comfort and dynamic athletic appearance.',
        'rating': 4.7,
        'reviews': 130,
        'sizes': ['6', '7', '8', '9'],
        'colors': [0xFFF48FB1, 0xFFFFFFFF],
        'isFavorite': false,
      },
      {
        'title': 'Classy Pastel Heels',
        'brand': 'Zara',
        'price': 3500.0,
        'image': 'assets/images/f2.jpg',
        'category': 'Footwear',
        'details': 'Elegant block heels in beautiful pastel shades, combining comfortable heel support and sleek aesthetics.',
        'rating': 4.5,
        'reviews': 58,
        'sizes': ['5', '6', '7', '8'],
        'colors': [0xFFF8BBD0, 0xFFE0F2F1],
        'isFavorite': false,
      }
    ];

    for (var prod in sampleProducts) {
      await productsCollection.add(prod);
    }
  }
}