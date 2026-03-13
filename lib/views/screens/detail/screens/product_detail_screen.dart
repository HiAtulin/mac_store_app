import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mac_store_app/models/product.dart';
import 'package:mac_store_app/provider/cart_provider.dart';
import 'package:mac_store_app/services/manage_http_response.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final _cartProvider = ref.read(cartProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.productName,
          style: GoogleFonts.quicksand(
            fontSize: 19,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              // 处理收藏按钮点击事件
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 260,
              height: 275,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 50,
                    child: Container(
                      width: 260,
                      height: 260,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: Color(0xFFD8DDFF),
                        borderRadius: BorderRadius.circular(130),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 22,
                    top: 0,
                    child: Container(
                      width: 216,
                      height: 274,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: Color(0xFF9CA8FF),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: SizedBox(
                        height: 300,
                        child: PageView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.product.images.length,
                          itemBuilder: (context, index) {
                            return Image.network(
                              widget.product.images[index],
                              width: 198,
                              height: 225,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.product.productName,
                  style: GoogleFonts.roboto(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: Color(0xFF3C55Ef),
                  ),
                ),
                Text(
                  '\$${widget.product.productPrice.toStringAsFixed(2)}',
                  style: GoogleFonts.roboto(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: Color(0xFF3C55Ef),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.product.category,
              style: GoogleFonts.roboto(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
                color: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "About",
                  style: GoogleFonts.lato(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.7,
                    color: Color(0xFF363330),
                  ),
                ),
                Text(
                  widget.product.description,
                  style: GoogleFonts.lato(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.5,
                    color: Color(0xFF363330),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            // 处理添加到购物车的逻辑
            _cartProvider.addProductToCart(
              productId: widget.product.id,
              productName: widget.product.productName,
              productPrice: widget.product.productPrice,
              category: widget.product.category,
              image: widget.product.images,
              productQuantity: widget.product.quantity,
              quantity: 1,
              vendorId: widget.product.vendorId,
              description: widget.product.description,
              fullName: widget.product.fullName,
            );
            showSnackBar(context, widget.product.productName);
          },
          child: Container(
            width: 386,
            height: 46,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Color(0xFF3854EE),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                "Add to Cart",
                style: GoogleFonts.lato(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.7,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
