import 'dart:convert';

class Favorite {
  final String productName;
  final int productPrice;
  final String category;
  final List<String> image;
  final String vendorId;
  final int productQuantity;
  int quantity;
  final String productId;
  final String description;
  final String fullName;

  Favorite({
    required this.productName,
    required this.productPrice,
    required this.category,
    required this.image,
    required this.vendorId,
    required this.productQuantity,
    required this.quantity,
    required this.productId,
    required this.description,
    required this.fullName,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'productPrice': productPrice,
      'quantity': quantity,
      'description': description,
      'category': category,
      'vendorId': vendorId,
      'fullName': fullName,
      'image': image,
      'productQuantity': productQuantity,
    };
  }

  String toJson() => json.encode(toMap());

  factory Favorite.fromMap(Map<String, dynamic> map) {
    return Favorite(
      productId: map['productId'] as String? ?? '',
      productName: map['productName'] as String? ?? '',
      productPrice: map['productPrice'] as int? ?? 0,
      quantity: map['quantity'] as int? ?? 0,
      description: map['description'] as String? ?? '',
      category: map['category'] as String? ?? '',
      vendorId: map['vendorId'] as String? ?? '',
      fullName: map['fullName'] as String? ?? '',
      image: List<String>.from(map['image'] as List<dynamic>),
      productQuantity: map['productQuantity'] as int? ?? 0,
    );
  }

  factory Favorite.fromJson(String source) =>
      Favorite.fromMap(json.decode(source));
}
