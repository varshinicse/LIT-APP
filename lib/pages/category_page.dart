import 'package:flutter/material.dart';
import 'package:lit/global_data.dart'; 
import 'package:lit/ecommerce/widgets/product_card.dart';
import 'package:lit/widgets/app_drawer.dart';
import 'package:lit/widgets/common_button.dart';
import '../ecommerce/wishlist_page.dart';
import 'package:lit/ecommerce/wishlist_service.dart';
import 'package:provider/provider.dart';
import '../ecommerce/widgets/sortby_bottomsheet.dart';
import 'package:lit/ecommerce/cart_service.dart';

class CategoryPage extends StatefulWidget {
  final String title;
  final String categoryKey;
  final String type;
  final String gender;

  const CategoryPage({
    super.key,
    required this.title,
    required this.categoryKey,
    required this.type,
    required this.gender,
  });

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> filteredProducts = allProducts.where((product) {
      final matchCategory = widget.categoryKey.toLowerCase() == 'shop all' ||
          product['category']?.toLowerCase() == widget.categoryKey.toLowerCase();
      final matchType = product['type']?.toLowerCase() == widget.type.toLowerCase();
      final matchGender = product['gender']?.toLowerCase() == widget.gender.toLowerCase();
      return matchCategory && matchType && matchGender;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Center(
          child: Image.asset(
            'assets/images/logo.png',
            height: 41,
          ),
        ),
        actions: [
          Consumer<WishlistService>(
            builder: (context, wishlist, child) => Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite_border, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const WishlistPage()),
                    );
                  },
                ),
                if (wishlist.count > 0)
                  Positioned(
                    right: 10,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                      child: Text(
                        '${wishlist.count}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),

      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.6)),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.arrow_back, color: Colors.white, size: 18),
                      SizedBox(width: 4),
                      Text(
                        'Back',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                child: Text(
                  'Found ${filteredProducts.length} items',
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 16),
                      const Icon(Icons.search, color: Color(0xFFCDB3FF), size: 20),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'You can search items',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.tune, color: Colors.white, size: 20),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: const Color(0xFF1C1C1E),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            builder: (_) => const SortByBottomSheet(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: GridView.builder(
                    itemCount: filteredProducts.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.53,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return ProductCard(
                        product: product,
                        onBuyNow: () {
                          Navigator.pushNamed(context, '/buy-now', arguments: product);
                        },
                        onAddToCart: () {
                          Provider.of<CartService>(context, listen: false).add(product);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.white, // ✅ white background
                              content: Text(
                                'Item added to cart',
                                style: TextStyle(
                                  color: Colors.black, // ✅ black text
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      bottomNavigationBar: CustomBottomNavBar(
  currentIndex: 1,
  isMarketplace: true,
  onTap: (index) {
    // Handle navigation
    if (index == 0) {
      Navigator.pushNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushNamed(context, '/cart');
    } else if (index == 2) {
      Navigator.pushNamed(context, '/profile');
    }
  },
),
    );
  }
}
