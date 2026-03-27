import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mac_store_app/models/product.dart';
import 'package:mac_store_app/provider/cart_provider.dart';
import 'package:mac_store_app/provider/favorite_provider.dart';
import 'package:mac_store_app/services/manage_http_response.dart';
import 'package:mac_store_app/views/screens/detail/screens/product_detail_screen.dart';

class ProductItemWidget extends ConsumerStatefulWidget {
  final Product product;
  const ProductItemWidget({super.key, required this.product});

  @override
  ConsumerState<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends ConsumerState<ProductItemWidget> {
  @override
  Widget build(BuildContext context) {
    final cartProviderData = ref.read(cartProvider.notifier);
    final favoriteProviderData = ref.read(favoriteProvider.notifier);
    ref.watch(favoriteProvider);
    final cartData = ref.watch(cartProvider);
    final isInCart = cartData.containsKey(widget.product.id);

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
          mainAxisSize: MainAxisSize.min,
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
                    top: 5,
                    right: 0,
                    child: InkWell(
                      child:
                          favoriteProviderData.getFavoriteItems.containsKey(
                            widget.product.id,
                          )
                          ? Icon(Icons.favorite, color: Colors.red)
                          : Icon(Icons.favorite_border),
                      onTap: () {
                        // 处理收藏按钮点击事件
                        if (favoriteProviderData.getFavoriteItems.containsKey(
                          widget.product.id,
                        )) {
                          // 已收藏，移除
                          favoriteProviderData.removeFavoriteItem(
                            widget.product.id,
                          );
                          showSnackBar(
                            context,
                            'removed ${widget.product.productName} from favorite',
                          );
                        } else {
                          // 未收藏，添加
                          favoriteProviderData.addProductToFavorite(
                            productName: widget.product.productName,
                            productPrice: widget.product.productPrice,
                            category: widget.product.category,
                            image: widget.product.images,
                            vendorId: widget.product.vendorId,
                            productQuantity: widget.product.quantity,
                            quantity: 1,
                            productId: widget.product.id,
                            description: widget.product.description,
                            fullName: widget.product.fullName,
                          );
                          showSnackBar(
                            context,
                            'added ${widget.product.productName} to favorite',
                          );
                        }
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 2,
                    child: InkWell(
                      onTap: isInCart
                          ? null
                          : () {
                              // 处理添加到购物车的逻辑
                              cartProviderData.addProductToCart(
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
                      child: Image.asset(
                        'assets/icons/cart.png',
                        width: 26,
                        height: 26,
                      ),
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
            widget.product.averageRating == 0
                ? SizedBox()
                : Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 12),
                      SizedBox(width: 4),
                      Text(
                        '${widget.product.averageRating.toStringAsFixed(1)}',
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
            SizedBox(height: 4),
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
