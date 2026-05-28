import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../services/firestore_service.dart';

class ProductViewModel extends ChangeNotifier {

  final FirestoreService _firestoreService =
      FirestoreService();

  /// ================= PRODUCTS =================
  List<ProductModel> _products = [];

  List<ProductModel> get products =>
      _products;

  /// ================= FAVORITES =================
  List<ProductModel> _favoriteProducts = [];

  List<ProductModel> get favoriteProducts =>
      _favoriteProducts;

  /// ================= LOADING =================
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  /// ================= SEARCH =================
  String _searchQuery = "";

  String get searchQuery =>
      _searchQuery;

  ProductViewModel() {
    fetchProducts();
  }

  /// =========================================================
  /// FETCH PRODUCTS
  /// =========================================================
  void fetchProducts() {

    _isLoading = true;

    notifyListeners();

    _firestoreService
        .getProducts()
        .listen(

      (List<ProductModel> productList) async {

        /// DATABASE EMPTY
        if (productList.isEmpty) {

          debugPrint(
            "Database empty. Seeding products...",
          );

          try {

            await _firestoreService
                .seedSampleProducts();

          } catch (e) {

            debugPrint(
              "Seed database error: $e",
            );
          }

          _isLoading = false;

          notifyListeners();

          return;
        }

        /// UPDATE PRODUCTS
        _products = productList;

        /// UPDATE FAVORITES
        _favoriteProducts =
            _products.where(
          (product) =>
              product.isFavorite == true,
        ).toList();

        _isLoading = false;

        notifyListeners();
      },

      onError: (error) {

        debugPrint(
          "Fetch products error: $error",
        );

        _isLoading = false;

        notifyListeners();
      },
    );
  }

  /// =========================================================
  /// SEED DATABASE
  /// =========================================================
  Future<void> seedDatabase() async {

    _isLoading = true;

    notifyListeners();

    try {

      await _firestoreService
          .seedSampleProducts();

    } catch (e) {

      debugPrint(
        "Seed database failed: $e",
      );

    } finally {

      _isLoading = false;

      notifyListeners();
    }
  }

  /// =========================================================
  /// UPDATE SEARCH
  /// =========================================================
  void updateSearch(String query) {

    _searchQuery = query;

    notifyListeners();
  }

  /// =========================================================
  /// FILTER PRODUCTS
  /// =========================================================
  List<ProductModel> getProductsByCategory(
    String category,
  ) {

    List<ProductModel> filtered =
        _products;

    /// CATEGORY FILTER
    if (category.toLowerCase() !=
        "all") {

      filtered = filtered.where(
        (product) {

          final String cat =
              product.category
                  .toLowerCase();

          final String mainCat =
              (product.mainCategory ??
                      "")
                  .toLowerCase();

          return cat ==
                  category
                      .toLowerCase() ||
              mainCat ==
                  category
                      .toLowerCase();
        },
      ).toList();
    }

    /// SEARCH FILTER
    if (_searchQuery.isNotEmpty) {

      filtered = filtered.where(
        (product) {

          return product.title
                  .toLowerCase()
                  .contains(
                    _searchQuery
                        .toLowerCase(),
                  ) ||
              product.brand
                  .toLowerCase()
                  .contains(
                    _searchQuery
                        .toLowerCase(),
                  );
        },
      ).toList();
    }

    return filtered;
  }

  /// =========================================================
  /// CHECK FAVORITE
  /// =========================================================
  bool isFavorite(
    ProductModel product,
  ) {

    return _favoriteProducts.any(
      (item) =>
          item.id == product.id,
    );
  }

  /// =========================================================
  /// TOGGLE FAVORITE
  /// =========================================================
  Future<void> toggleFavorite(
    ProductModel product,
  ) async {

    final int index =
        _products.indexWhere(
      (item) =>
          item.id == product.id,
    );

    if (index == -1) return;

    /// CURRENT PRODUCT
    final ProductModel currentProduct =
        _products[index];

    /// UPDATED PRODUCT
    final ProductModel updatedProduct =
        currentProduct.copyWith(
      isFavorite:
          !(currentProduct.isFavorite ??
              false),
    );

    /// UPDATE LOCAL PRODUCT LIST
    _products[index] = updatedProduct;

    /// UPDATE FAVORITES LIST
    if (updatedProduct.isFavorite ==
        true) {

      final bool alreadyExists =
          _favoriteProducts.any(
        (item) =>
            item.id ==
            updatedProduct.id,
      );

      if (!alreadyExists) {

        _favoriteProducts.add(
          updatedProduct,
        );
      }

    } else {

      _favoriteProducts.removeWhere(
        (item) =>
            item.id ==
            updatedProduct.id,
      );
    }

    notifyListeners();

    /// UPDATE FIRESTORE
    try {

      await _firestoreService
          .updateProduct(
        updatedProduct,
      );

      debugPrint(
        "Favorite updated successfully",
      );

    } catch (e) {

      debugPrint(
        "Firestore update failed: $e",
      );
    }
  }

  /// =========================================================
  /// REMOVE FAVORITE
  /// =========================================================
  Future<void> removeFavorite(
    ProductModel product,
  ) async {

    final int index =
        _products.indexWhere(
      (item) =>
          item.id == product.id,
    );

    if (index == -1) return;

    final ProductModel updatedProduct =
        _products[index].copyWith(
      isFavorite: false,
    );

    _products[index] = updatedProduct;

    _favoriteProducts.removeWhere(
      (item) =>
          item.id == product.id,
    );

    notifyListeners();

    try {

      await _firestoreService
          .updateProduct(
        updatedProduct,
      );

    } catch (e) {

      debugPrint(
        "Remove favorite failed: $e",
      );
    }
  }

  /// =========================================================
  /// REFRESH PRODUCTS
  /// =========================================================
  Future<void> refreshProducts() async {

    fetchProducts();
  }

  /// =========================================================
  /// CLEAR SEARCH
  /// =========================================================
  void clearSearch() {

    _searchQuery = "";

    notifyListeners();
  }

  /// =========================================================
  /// CLEAR FAVORITES
  /// =========================================================
  Future<void> clearFavorites() async {

    try {

      for (final product
          in _favoriteProducts) {

        final updated =
            product.copyWith(
          isFavorite: false,
        );

        await _firestoreService
            .updateProduct(updated);
      }

      _favoriteProducts.clear();

      for (int i = 0;
          i < _products.length;
          i++) {

        _products[i] =
            _products[i].copyWith(
          isFavorite: false,
        );
      }

      notifyListeners();

    } catch (e) {

      debugPrint(
        "Clear favorites failed: $e",
      );
    }
  }
}