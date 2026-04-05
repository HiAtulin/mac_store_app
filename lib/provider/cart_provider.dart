import 'dart:convert';

import 'package:flutter_riverpod/legacy.dart';
import 'package:mac_store_app/models/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

final cartProvider = StateNotifierProvider<CartNotifier, Map<String, Cart>>((
  ref,
) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<Map<String, Cart>> {
  CartNotifier() : super({}){
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final cartString = prefs.getString('cart_items');
    if (cartString != null) {
      final Map<String, dynamic> cartMap = jsonDecode(cartString);
      final cartItems = cartMap.map(
        (key, value) => MapEntry(key, Cart.fromJson(value)),
      );
      state = cartItems;
    }
  }

  Future<void> _saveCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final cartString = jsonEncode(state);
    await prefs.setString('cart_items', cartString);
  }

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
      _saveCartItems();
    } else {
      state = {
        ...state,
        productId: Cart(
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
        ),
      };
      _saveCartItems();
    }
  }
  // 增加购物车中的商品数量 
  void incrementCartItem(String productId) {
    if (state.containsKey(productId)) {
      state[productId]!.quantity++;
      state = {...state};
      _saveCartItems();
    }
  }

  // 减少购物车中的商品数量
  void decrementCartItem(String productId) {
    if (state.containsKey(productId)) {
      state[productId]!.quantity--;
      state = {...state};
      _saveCartItems();
    }
  }

  // 从购物车中移除商品
  void removeCartItem(String productId) {
    if (state.containsKey(productId)) {
      state.remove(productId);
      state = {...state};
      _saveCartItems();
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

  Map<String, Cart> get getCartItems => state;
}
