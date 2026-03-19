import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mac_store_app/provider/cart_provider.dart';
import 'package:mac_store_app/views/screens/main_screen.dart';
import 'package:mac_store_app/views/screens/detail/screens/checkout_screen.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartData = ref.watch(cartProvider);
    final _cartProvider = ref.read(cartProvider.notifier);
    final totalAmount = ref.read(cartProvider.notifier).calculateTotalPrice();
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
                            cartData.length.toString(),
                            style: TextStyle(
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
                  "My Cart",
                  style: TextStyle(
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
      body: cartData.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    "Your cart is empty \nAdd some items to your cart",
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
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 49,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 49,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(color: Color(0xFFD7DDFF)),
                          ),
                        ),
                        Positioned(
                          left: 44,
                          top: 19,
                          child: Container(
                            width: 10,
                            height: 10,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 69,
                          top: 14,
                          child: Text(
                            "You have ${cartData.length} items in your cart",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.7,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: cartData.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartData.values.toList()[index];
                      return Card(
                        child: SizedBox(
                          height: 200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: Image.network(
                                  cartItem.image[0],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cartItem.productName,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.7,
                                    ),
                                  ),
                                  Text(
                                    "Category: ${cartItem.category}",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      letterSpacing: 1.7,
                                    ),
                                  ),
                                  Text(
                                    "\$${cartItem.productPrice.toStringAsFixed(2)}",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 120,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF102DE1),
                                        ),
                                        child: Row(
                                          children: [
                                            IconButton(
                                              icon: Icon(
                                                Icons.remove,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {
                                                if (cartItem.quantity > 1) {
                                                  setState(() {
                                                    _cartProvider
                                                        .decrementCartItem(
                                                          cartItem.productId,
                                                        );
                                                  });
                                                }
                                              },
                                            ),
                                            Text(
                                              cartItem.quantity.toString(),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {
                                                // if (cartItem.quantity <
                                                //     cartItem.productQuantity) {}
                                                setState(() {
                                                  _cartProvider
                                                      .incrementCartItem(
                                                        cartItem.productId,
                                                      );
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      setState(() {
                                        _cartProvider.removeCartItem(
                                          cartItem.productId,
                                        );
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
      bottomNavigationBar: Container(
        width: 416,
        height: 89,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 416,
                height: 89,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xFFC4C4C4)),
                ),
              ),
            ),
            Align(
              alignment: Alignment(-0.63, -0.26),
              child: Text(
                "Subtotal",
                style: TextStyle(
                  color: Color(0xFFA1A1A1),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Align(
              alignment: Alignment(-0.19, -0.31),
              child: Text(
                "\$${totalAmount.toStringAsFixed(2)}",
                style: TextStyle(
                  color: Color(0xFFFF6464),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Align(
              alignment: Alignment(0.83, -1),
              child: InkWell(
                onTap: totalAmount > 0
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckoutScreen(),
                          ),
                        );
                      }
                    : null,
                child: Container(
                  width: 166,
                  height: 71,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: totalAmount > 0 ? Color(0xFF1532E7) : Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Checkout",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.arrow_forward, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
