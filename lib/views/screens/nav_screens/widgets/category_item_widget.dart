import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mac_store_app/controllers/category_controller.dart';
import 'package:mac_store_app/models/category.dart';
import 'package:mac_store_app/provider/category_provider.dart';
import 'package:mac_store_app/views/screens/detail/screens/inner_category_screen.dart';
import 'package:mac_store_app/views/screens/nav_screens/widgets/reusable_text_widget.dart';

class CategoryItemWidget extends ConsumerStatefulWidget {
  const CategoryItemWidget({super.key});

  @override
  ConsumerState<CategoryItemWidget> createState() => _CategoryItemWidgetState();
}

class _CategoryItemWidgetState extends ConsumerState<CategoryItemWidget> {
  Future<void> _fetchCategories() async {
    try {
      final CategoryController categoryController = CategoryController();
      final categories = await categoryController.loadCategories();
      ref.read(categoryProvider.notifier).setCategories(categories);
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReusableTextWidget(title: 'Categories', subtitle: 'View All'),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: categories.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 4.0, // 减小行间距
            crossAxisSpacing: 8.0,
            childAspectRatio: 1.2, // 调整宽高比，让高度更小
          ),
          itemBuilder: (context, index) {
            final category = categories[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return InnerCategoryScreen(category: category);
                    },
                  ),
                );
              },
              child: Column(
                children: [
                  Image.network(width: 47, height: 47, category.image),
                  Text(
                    category.name,
                    style: GoogleFonts.quicksand(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
