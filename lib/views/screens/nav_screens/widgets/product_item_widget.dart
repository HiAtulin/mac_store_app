import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mac_store_app/models/product.dart';
import 'package:mac_store_app/views/screens/detail/screens/product_detail_screen.dart';

class ProductItemWidget extends StatefulWidget {
  final Product product;
  const ProductItemWidget({super.key, required this.product});

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: widget.product),
          ),
        );
      },
      child: Container(
        width: 170,
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 170,
              decoration: BoxDecoration(
                color: Color(0xffF2F2F2),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                children: [
                  Image.network(
                    widget.product.images[0],
                    fit: BoxFit.cover,
                    height: 170,
                    width: 170,
                  ),
                  Positioned(
                    top: 15,
                    right: 2,
                    child: Image.asset(
                      'assets/icons/love.png',
                      width: 26,
                      height: 26,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 2,
                    child: Image.asset(
                      'assets/icons/cart.png',
                      width: 26,
                      height: 26,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Text(
              widget.product.productName,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: GoogleFonts.quicksand(
                fontSize: 14,
                color: Color(0xFF212121),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              widget.product.category,
              style: GoogleFonts.quicksand(
                fontSize: 14,
                color: Color(0xff868D94),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '\$${widget.product.productPrice.toStringAsFixed(2)}',
              style: GoogleFonts.quicksand(
                fontSize: 15,
                color: Colors.purple,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
