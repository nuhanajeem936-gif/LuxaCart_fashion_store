import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/firestore_service.dart';

class CartViewModel extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  List<ProductModel> _cartItems = [];
  List<ProductModel> get cartItems => _cartItems;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  CartViewModel() {
    _firestoreService.getCart().listen((items) {
      _cartItems = items;
      _isLoading = false;
      notifyListeners();
    });
  }

  /// ===============================
  /// TOTAL PRICE
  /// ===============================
  double get totalPrice {
    return _cartItems.fold(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );
  }

  /// ===============================
  /// ADD TO CART
  /// ===============================
  Future<void> addToCart(ProductModel product) async {
    final index =
        _cartItems.indexWhere((item) => item.id == product.id);

    if (index != -1) {
      final updatedItem = _cartItems[index].copyWith(
        quantity: _cartItems[index].quantity + 1,
      );

      _cartItems[index] = updatedItem;

      await _firestoreService.addToCart(updatedItem);
    } else {
      final newItem = product.copyWith(quantity: 1);

      _cartItems.add(newItem);

      await _firestoreService.addToCart(newItem);
    }

    notifyListeners();
  }

  /// ===============================
  /// REMOVE FROM CART
  /// ===============================
  Future<void> removeFromCart(String productId) async {
    _cartItems.removeWhere((item) => item.id == productId);

    await _firestoreService.removeFromCart(productId);

    notifyListeners();
  }

  /// ===============================
  /// UPDATE QUANTITY
  /// ===============================
  Future<void> updateQuantity(
      ProductModel product, int newQuantity) async {
    final index =
        _cartItems.indexWhere((item) => item.id == product.id);

    if (index == -1) return;

    if (newQuantity <= 0) {
      await removeFromCart(product.id);
      return;
    }

    final updatedItem = product.copyWith(quantity: newQuantity);

    _cartItems[index] = updatedItem;

    await _firestoreService.addToCart(updatedItem);

    notifyListeners();
  }

  /// ===============================
  /// CLEAR CART
  /// ===============================
  Future<void> clearCart() async {
    for (var item in _cartItems) {
      await _firestoreService.removeFromCart(item.id);
    }

    _cartItems.clear();

    notifyListeners();
  }
}