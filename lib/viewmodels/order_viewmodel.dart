import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/firestore_service.dart';

class OrderViewModel extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  bool _isPlacingOrder = false;
  bool get isPlacingOrder => _isPlacingOrder;

  List<Map<String, dynamic>> _orders = [];
  List<Map<String, dynamic>> get orders => _orders;

  OrderViewModel() {
    _firestoreService.getOrders().listen((orderList) {
      _orders = orderList;
      notifyListeners();
    });
  }

  Future<bool> placeOrder(List<ProductModel> items, double total, Map<String, dynamic> deliveryDetails) async {
    _isPlacingOrder = true;
    notifyListeners();

    try {
      await _firestoreService.placeOrder(items, total, deliveryDetails);
      _isPlacingOrder = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isPlacingOrder = false;
      notifyListeners();
      return false;
    }
  }
}
