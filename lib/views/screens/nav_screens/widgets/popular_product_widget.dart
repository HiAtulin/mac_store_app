import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mac_store_app/controllers/product_controller.dart';
import 'package:mac_store_app/models/product.dart';
import 'package:mac_store_app/provider/product_provider.dart';
import 'package:mac_store_app/views/screens/nav_screens/widgets/product_item_widget.dart';

class PopularProductWidget extends ConsumerStatefulWidget {
  const PopularProductWidget({super.key});

  @override
  ConsumerState<PopularProductWidget> createState() =>
      _PopularProductWidgetState();
}

class _PopularProductWidgetState extends ConsumerState<PopularProductWidget> {
  Future<void> _fetchProducts() async {
    final ProductController productController = await ProductController();
    try {
      final List<Product> products = await productController
          .loadPopularProducts();
      ref.read(productProvider.notifier).setProducts(products);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final List<Product> products = ref.watch(productProvider);
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          final Product product = products[index];
          return ProductItemWidget(product: product);
        },
      ),
    );
  }
}
