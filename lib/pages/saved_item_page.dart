import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lit/data/saved_items.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lit/widgets/app_drawer.dart';
import 'package:lit/widgets/notification_bell.dart';
import 'package:lit/widgets/common_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lit/ecommerce/cart_page.dart';
import 'package:lit/pages/shop_page.dart';
class SavedItemPage extends StatefulWidget {
  const SavedItemPage({super.key});

  @override
  State<SavedItemPage> createState() => _SavedItemPageState();
}

class _SavedItemPageState extends State<SavedItemPage> {
  int currentIndex = 1; // For bottom navigation bar


  void _removeItem(int index) {
    setState(() {
      SavedItems.removeItem(index);
    });
  }

  void _onNavTapped(int index) {
    setState(() => currentIndex = index);

    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home'); // Home page
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SavedItemPage()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CartPage(cartItems: [])),
      );
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Image.asset('assets/images/logo.png', height: 40),
        centerTitle: true,
        actions: const [
          NotificationBell(),
          SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Dark overlay
          Container(color: Colors.black.withOpacity(0.6)),
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              children: [
                // Back button
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.arrow_back, color: Colors.white),
                        SizedBox(width: 8),
                        Text("Back", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Title in two lines
                Column(
                  children: [
                    Text(
                      'SAVED',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.kronaOne(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        height: 1.0,
                      ),
                    ),
                    Text(
                      'PRODUCTS',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.kronaOne(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Grid of saved products
                SavedItems.items.isEmpty
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Text(
                            'No saved products yet',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      )
                    : GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              // Slightly taller tiles to avoid overflow on dense content
                              childAspectRatio: 0.62,
                            ),
                            itemCount: SavedItems.items.length,
                            itemBuilder: (context, index) {
                              final item = SavedItems.items[index];
                              return _buildSavedItemCard(item, index);
                            },
                      ),
              ],
            ),
          ),
        ],
      ),

      // ✅ Shared Bottom nav bar (same as game_page.dart)
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex, // highlight Saved tab
        onTap: (index) {
          // mirror game_page behavior
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          }
        },
        isMarketplace: false,
        isGame: true, // middle button goes to /saved, extra grocery icon visible
      ),
    );
  }

  Widget _buildSavedItemCard(Map<String, dynamic> item, int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
          color: Colors.black,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
          mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            // 🔹 Top Image Section
              Stack(
                children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    ),
                    child: Image.asset(
                      item['imagePath'],
                    height: 140,
                      width: double.infinity,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox(
                        height: 140,
                        child: Center(
                          child: Icon(Icons.broken_image, color: Colors.white54, size: 60),
                        ),
                      );
                    },
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                    padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                      ),
                    child: const Icon(Icons.bookmark, color: Colors.white, size: 18),
                    ),
                  ),
                ],
              ),

            const SizedBox(height: 8),

            // 🔹 Bottom Glassmorphism Section
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    border: Border.all(color: Colors.white.withOpacity(0.12)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0.18),
                        Colors.white.withOpacity(0.04),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  constraints: const BoxConstraints(minHeight: 112),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                  item['label'],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                          color: const Color(0xFF9333EA),
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                      const SizedBox(height: 3),
                      Text(
                  item['price'] ?? '₹0',
                        textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),

                      // 🔹 Button + Delete
                      Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('View in store feature coming soon'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Container(
                                height: 36,
                          decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const RadialGradient(
                                    center: Alignment(0.08, 0.08),
                                    radius: 7.98,
                                    colors: [
                                      Color.fromRGBO(0, 0, 0, 0.8),
                                      Color.fromRGBO(147, 51, 234, 0.4),
                                    ],
                                    stops: [0.0, 0.5],
                                  ),
                                  border: Border.all(color: Color(0xFFAEAEAE), width: 1),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x66000000),
                                      offset: Offset(0, 4),
                                      blurRadius: 4,
                                    ),
                                  ],
                          ),
                          child: Center(
                            child: Text(
                              'VIEW IN STORE',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                      fontSize: 11,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => _removeItem(index),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white.withOpacity(0.12)),
                        ),
                        padding: const EdgeInsets.all(6),
                        child: const Icon(Icons.delete, color: Colors.redAccent, size: 18),
                      ),
                    ),
                        ],
                      ),
                    ],
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
