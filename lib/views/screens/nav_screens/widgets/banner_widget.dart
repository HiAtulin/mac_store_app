import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mac_store_app/controllers/banner_controller.dart';
import 'package:mac_store_app/models/banner_model.dart';
import 'package:mac_store_app/provider/banner_provider.dart';

class BannerWidget extends ConsumerStatefulWidget {
  BannerWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends ConsumerState<BannerWidget> {
  Future<void> _fetchBanners() async {
    final BannerController bannerController = await BannerController();
    try {
      final List<BannerModel> banners = await bannerController.loadBanners();
      ref.read(bannerProvider.notifier).setBanners(banners);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchBanners();
  }

  @override
  Widget build(BuildContext context) {
    final List<BannerModel> banners = ref.watch(bannerProvider);
    return Container(
      height: 190,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(5),
      ),
      child: PageView.builder(
        itemCount: banners.length,
        itemBuilder: (context, index) {
          final banner = banners[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(banner.image, fit: BoxFit.cover),
          );
        },
      ),
    );
  }
}
