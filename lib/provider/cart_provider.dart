import 'package:flutter_riverpod/legacy.dart';
import 'package:mac_store_app/models/cart.dart';

final cartProvider = StateNotifierProvider<CartNotifier, Map<String, Cart>>((
  ref,
) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<Map<String, Cart>> {
  CartNotifier() : super({});
  void addProductToCart({
    required String productId,
    required String productName,
    required int productPrice,
    required String category,
    required List<String> image,
    required int productQuantity,
    required int quantity,
    required String vendorId,
    required String description,
    required String fullName,
  }) {
    if (state.containsKey(productId)) {
      state = {
        ...state,
        productId: Cart(
          productName: state[productId]!.productName,
          productPrice: state[productId]!.productPrice,
          category: state[productId]!.category,
          image: state[productId]!.image,
          productQuantity: state[productId]!.productQuantity,
          quantity: state[productId]!.quantity + 1,
          productId: state[productId]!.productId,
          description: state[productId]!.description,
          fullName: state[productId]!.fullName,
          vendorId: state[productId]!.vendorId,
        ),
      };
    } else {
      state[productId] = Cart(
        productName: productName,
        productPrice: productPrice,
        category: category,
        image: image,
        productQuantity: productQuantity,
        quantity: quantity,
        productId: productId,
        description: description,
        fullName: fullName,
        vendorId: vendorId,
      );
    }
  }

  void incrementCartItem(String productId) {
    if (state.containsKey(productId)) {
      state[productId]!.quantity++;
      state = {...state};
    }
  }

  // 减少购物车中的商品数量
  void decrementCartItem(String productId) {
    if (state.containsKey(productId)) {
      state[productId]!.quantity--;
      state = {...state};
    }
  }

  // 从购物车中移除商品
  void removeCartItem(String productId) {
    if (state.containsKey(productId)) {
      state.remove(productId);
    }
  }

  // 计算购物车中所有商品的总价格
  double calculateTotalPrice() {
    double totalPrice = 0.0;
    state.forEach((key, cartItem) {
      totalPrice += cartItem.productPrice * cartItem.quantity;
    });
    return totalPrice;
  }
}
