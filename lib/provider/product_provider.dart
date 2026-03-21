import 'package:flutter_riverpod/legacy.dart';
import 'package:mac_store_app/models/product.dart';

class ProductProvider extends StateNotifier<List<Product>> {
  ProductProvider() : super([]);
  void setProducts(List<Product> products) {
    state = products;
  }
}
final productProvider = StateNotifierProvider<ProductProvider, List<Product>>(
  (ref) => ProductProvider(),
);