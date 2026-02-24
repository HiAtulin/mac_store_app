import 'dart:convert';

import 'package:mac_store_app/global_variables.dart';
import 'package:mac_store_app/models/subcategory.dart';
import 'package:http/http.dart' as http;

class SubcategoryController {
  Future<List<Subcategory>> getSubCategoriesByCategoryName(
    String categoryName,
  ) async {
    try {
      http.Response response = await http.get(
        Uri.parse("$url/api/category/$categoryName/subcategories"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          return data
              .map((subcategory) => Subcategory.fromJson(subcategory))
              .toList();
        } else {
          print("subcategory not found");
          return [];
        }
      } else if (response.statusCode == 404) {
        print("subcategory not found");
        return [];
      } else {
        print("Error loading subcategories");
        return [];
      }
    } catch (e) {
      print("Error loading subcategories: $e");
      return [];
    }
  }
}
