import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:mac_store_app/global_variables.dart';
import 'package:mac_store_app/models/category.dart';

class CategoryController {

  Future<List<Category>> loadCategories() async {
    try {
      http.Response response = await http.get(
        Uri.parse("$url/api/categories"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Category> categories = data
            .map((category) => Category.fromJson(category))
            .toList();
        return categories;
      } else {
        throw Exception("Error loading categories");
      }
    } catch (e) {
      throw Exception("Error loading categories: $e");
    }
  }
}
