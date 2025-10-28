import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lit/data/global_data.dart';
import 'package:lit/ecommerce/cart_page.dart';

// Define cartItems list if it's not defined in global_data.dart
List<Map<String, dynamic>> cartItems = [];

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final bool isMarketplace; // 🔹 NEW PARAMETER
  final bool isGame;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.isMarketplace = false, // 🔹 DEFAULT VALUE
    this.isGame = false,
  });

  void addToCart(BuildContext context, Map<String, dynamic> product) {
    cartItems.add(product); // Using the global cartItems list
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
        child: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0.08, 0.08),
              radius: 15.98,
              colors: [
                Color.fromRGBO(0, 0, 0, 0.8),
                Color.fromRGBO(147, 51, 234, 0.4),
              ],
              stops: [0.0, 0.5],
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x66000000),
                blurRadius: 30,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: SizedBox(
            height: 60,
            child: BottomAppBar(
              color: Colors.transparent,
              elevation: 0,
              shape: const CircularNotchedRectangle(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28.0,
                  vertical: 4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 🔹 Home Icon
                    GestureDetector(
                      onTap: () => onTap(0),
                      child: Image.asset(
                        'assets/images/home_icon.png',
                        width: 24,
                        height: 24,
                        color: currentIndex == 0
                            ? const Color(0x718D00FF)
                            : Colors.white,
                      ),
                    ),

                    // 🔹 Middle Action Icon with Badge (Cart or IR or Save)
                    GestureDetector(
                      onTap: () {
                        if (isGame) {
                          Navigator.pushNamed(context, '/saved');
                        } else if (isMarketplace) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CartPage(cartItems: cartItems),
                            ),
                          );
                        } else {
                          Navigator.pushNamed(context, '/ir-icon');
                        }
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          // Icon (Cart / IR / Save Products)
                          Image.asset(
                            isGame
                                ? 'assets/images/save-pro-icon.png'
                                : isMarketplace
                                    ? 'assets/images/grocery-store.png'
                                    : 'assets/images/ir_icon.png',
                            width: 24,
                            height: 24,
                            color: currentIndex == 1
                                ? const Color(0x718D00FF)
                                : Colors.white,
                          ),

                          // 🔹 Badge (Cart Count)
                          if (isMarketplace && cartItems.isNotEmpty)
                            Positioned(
                              right: -6,
                              top: -6,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '${cartItems.length}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    // 🔹 Grocery Store Icon (only for game pages)
                    if (isGame)
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CartPage(cartItems: cartItems),
                          ),
                        ),
                        child: Image.asset(
                          'assets/images/grocery-store.png',
                          width: 24,
                          height: 24,
                          color: currentIndex == 3
                              ? const Color(0x718D00FF)
                              : Colors.white,
                        ),
                      ),

                    // 🔹 Profile Icon
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/profile'),
                      child: Image.asset(
                        'assets/images/profile_icon.png',
                        width: 24,
                        height: 24,
                        color: currentIndex == (isGame ? 4 : 2)
                            ? const Color(0x718D00FF)
                            : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
