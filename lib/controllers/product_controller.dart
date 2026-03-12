import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mac_store_app/global_variables.dart';
import 'package:mac_store_app/models/product.dart';

class ProductController {
  Future<List<Product>> loadPopularProducts() async {
    try {
      http.Response response = await http.get(
        Uri.parse("$url/api/popular-products"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Product> products = data
            .map((product) => Product.fromMap(product as Map<String, dynamic>))
            .toList();
        return products;
      } else {
        throw Exception("Error loading popular products");
      }
    } catch (e) {
      throw Exception("Error loading popular products: $e");
    }
  }
  Future<List<Product>> loadProductsByCategory(String category) async {
    try {
      http.Response response = await http.get(
        Uri.parse("$url/api/products-by-category/$category"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Product> products = data
            .map((product) => Product.fromMap(product as Map<String, dynamic>))
            .toList();
        return products;
      } else {
        throw Exception("Error loading products by category");
      }
    } catch (e) {
      throw Exception("Error loading products by category: $e");
    }
  }
}
