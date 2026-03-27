import 'package:flutter_riverpod/legacy.dart';
import 'package:mac_store_app/models/favorite.dart';

class FavoriteNotifier extends StateNotifier<Map<String, Favorite>> {
  FavoriteNotifier() : super({});

  void addProductToFavorite({
    required String productName,
    required int productPrice,
    required String category,
    required List<String> image,
    required String vendorId,
    required int productQuantity,
    required int quantity,
    required String productId,
    required String description,
    required String fullName,
  }) {
    state[productId] = Favorite(
      productName: productName,
      productPrice: productPrice,
      category: category,
      image: image,
      vendorId: vendorId,
      productQuantity: productQuantity,
      quantity: quantity,
      productId: productId,
      description: description,
      fullName: fullName,
    );
    state = {...state};
  }

  void removeFavoriteItem(String productId) {
    state.remove(productId);
    state = {...state};
  }

  Map<String, Favorite> get getFavoriteItems => state; // 获取所有收藏商品
}

final favoriteProvider =
    StateNotifierProvider<FavoriteNotifier, Map<String, Favorite>>(
      (ref) => FavoriteNotifier(),
    );
