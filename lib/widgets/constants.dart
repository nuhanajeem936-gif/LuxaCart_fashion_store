import '../models/product_model.dart';
import '../utils/dummy_data.dart';

void addProductToCart(ProductModel product) {
  final index = itemsInCart.indexWhere(
    (item) => item.id == product.id,
  );

  if (index != -1) {
    final existingItem = itemsInCart[index];

    itemsInCart[index] = existingItem.copyWith(
      quantity: existingItem.quantity + 1,
    );
  } else {
    itemsInCart.add(
      product.copyWith(quantity: 1),
    );
  }
}