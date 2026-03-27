import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mac_store_app/provider/favorite_provider.dart';
import 'package:mac_store_app/services/manage_http_response.dart';
import 'package:mac_store_app/views/screens/main_screen.dart';

class FavoriteScreen extends ConsumerStatefulWidget {
  const FavoriteScreen({super.key});

  @override
  ConsumerState<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends ConsumerState<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final favoriteItemData = ref.watch(favoriteProvider);
    final favoriteListProvider = ref.read(favoriteProvider.notifier);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.20,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 118,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/icons/cartb.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 322,
                top: 52,
                child: Stack(
                  children: [
                    Image.asset("assets/icons/not.png", width: 25, height: 25),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 20,
                        height: 20,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.yellow.shade800,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            favoriteItemData.length.toString(),
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 61,
                top: 51,
                child: Text(
                  "My Favorite",
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: favoriteItemData.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    "Your favorite is empty \nAdd some items to your favorite",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainScreen()),
                      );
                    },
                    child: Text(
                      "Add Items",
                      style: TextStyle(
                        color: Colors.yellow.shade800,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: favoriteItemData.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final favoriteItem = favoriteItemData.values.toList()[index];
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    width: 335,
                    height: 96,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(),
                    child: SizedBox(
                      width: double.infinity,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 336,
                              height: 97,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Color(0xFFEFF0F2)),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 13,
                            top: 9,
                            child: Container(
                              width: 78,
                              height: 78,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Color(0xFFBCC5FF),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 275,
                            top: 16,
                            child: Text(
                              '\$${favoriteItem.productPrice.toStringAsFixed(2)}',
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 101,
                            top: 14,
                            child: SizedBox(
                              width: 162,
                              child: Text(
                                favoriteItem.productName,
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 23,
                            top: 14,
                            child: Image.network(
                              favoriteItem.image[0],
                              width: 56,
                              height: 67,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            left: 284,
                            top: 47,
                            child: IconButton(
                              onPressed: () {
                                favoriteListProvider.removeFavoriteItem(
                                  favoriteItem.productId,
                                );
                                showSnackBar(
                                  context,
                                  'removed ${favoriteItem.productName} from favorite',
                                );
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
