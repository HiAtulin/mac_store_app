import 'package:flutter/material.dart';

class InnerBannerWidget extends StatefulWidget {
  final String image;
  const InnerBannerWidget({super.key, required this.image});

  @override
  State<InnerBannerWidget> createState() => _InnerBannerWidgetState();
}

class _InnerBannerWidgetState extends State<InnerBannerWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 170,
        width: MediaQuery.of(context).size.width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(widget.image, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
