import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mac_store_app/controllers/subcategory_controller.dart';
import 'package:mac_store_app/models/category.dart';
import 'package:mac_store_app/models/subcategory.dart';
import 'package:mac_store_app/views/screens/detail/screens/widgets/inner_banner_widget.dart';
import 'package:mac_store_app/views/screens/detail/screens/widgets/inner_header_widget.dart';
import 'package:mac_store_app/views/screens/detail/screens/widgets/subcategory_tile_widget.dart';

class InnerCategoryContentWidget extends StatefulWidget {
  final Category category;
  const InnerCategoryContentWidget({super.key, required this.category});

  @override
  State<InnerCategoryContentWidget> createState() =>
      _InnerCategoryContentWidgetState();
}

class _InnerCategoryContentWidgetState
    extends State<InnerCategoryContentWidget> {
  late Future<List<Subcategory>> _subCategories;
  final SubcategoryController _subcategoryController = SubcategoryController();
  @override
  void initState() {
    super.initState();
    _subCategories = _subcategoryController.getSubCategoriesByCategoryName(
      widget.category.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.20,
        ),
        child: InnerHeaderWidget(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InnerBannerWidget(image: widget.category.banner),
            Center(
              child: Text(
                "Shop By Subcategories",
                style: GoogleFonts.quicksand(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.7,
                ),
              ),
            ),
            FutureBuilder<List<Subcategory>>(
              future: _subCategories,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No subcategories found'));
                } else {
                  final subcategories = snapshot.data!;
                  return SizedBox(
                    height: 400, // 限制 GridView 的高度
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: List.generate(
                          (subcategories.length / 7).ceil(),
                          (setIndex) {
                            final start = setIndex * 7;
                            final end = (setIndex + 1) * 7;
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: subcategories
                                    .sublist(
                                      start,
                                      end > subcategories.length
                                          ? subcategories.length
                                          : end,
                                    )
                                    .map(
                                      (subcategory) => SubcategoryTileWidget(
                                        image: subcategory.image,
                                        title: subcategory.subcategoryName,
                                      ),
                                    )
                                    .toList(),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
