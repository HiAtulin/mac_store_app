import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mac_store_app/models/subcategory.dart';

class SubcategoryTileWidget extends StatefulWidget {
  final String image;
  final String title;
  const SubcategoryTileWidget({
    super.key,
    required this.image,
    required this.title,
  });

  @override
  State<SubcategoryTileWidget> createState() => _SubcategoryTileWidgetState();
}

class _SubcategoryTileWidgetState extends State<SubcategoryTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey.shade200.withOpacity(0.7),
            borderRadius: BorderRadius.circular(50),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(widget.image, fit: BoxFit.cover),
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          width: 110,
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.quicksand(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
