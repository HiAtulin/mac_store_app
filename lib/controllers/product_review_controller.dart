import 'package:http/http.dart' as http;
import 'package:mac_store_app/global_variables.dart';
import 'package:mac_store_app/models/product_review.dart';
import 'package:mac_store_app/services/manage_http_response.dart';

class ProductReviewController {
  uploadReview({
    required String buyerId,
    required String email,
    required String fullName,
    required String productId,
    required double rating,
    required String review,
    required context,
  }) async {
    // 实现上传逻辑
    try {
      final ProductReview productReview = ProductReview(
        buyerId: buyerId,
        email: email,
        fullName: fullName,
        productId: productId,
        rating: rating,
        review: review,
        id: '',
      );
      http.Response response = await http.post(
        Uri.parse('$url/api/product-review'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: productReview.toJson(),
      );
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          // 处理成功逻辑
          showSnackBar(context, 'You have successfully uploaded a review.');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
