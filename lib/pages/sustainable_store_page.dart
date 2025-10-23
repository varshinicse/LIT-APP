import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lit/widgets/app_drawer.dart';
import 'package:lit/widgets/common_button.dart';
import 'package:provider/provider.dart';
import 'package:lit/ecommerce/cart_service.dart';
import 'package:lit/pages/category_page.dart';
import 'package:lit/ecommerce/wishlist_service.dart';
import '../ecommerce/wishlist_page.dart';
import '../ecommerce/buy_now_page.dart';
import 'package:lit/global_data.dart'; // <-- added so cartItems is available

class SustainableStorePage extends StatefulWidget {
  const SustainableStorePage({super.key});

  @override
  State<SustainableStorePage> createState() => _SustainableStorePageState();
}

class _SustainableStorePageState extends State<SustainableStorePage> {
  final WishlistService wishlist = WishlistService();

  bool _isInWishlist(Map<String, dynamic> item) {
    return wishlist.items.any((wishItem) => wishItem['id'] == item['id']);
  }

  final List<String> _searchHints = [
    'Search sustainable men fashion',
    'Search eco-friendly women wear',
    'Search green accessories',
    'Search sustainable products',
  ];

  final freshArrivalImages = [
    'assets/images/fa1.jpg',
    'assets/images/fa2.jpg',
    'assets/images/fa3.jpg',
    'assets/images/fa4.jpg',
    'assets/images/fa5.jpg',
  ];

  int _hintIndex = 0;
  String _currentHint = '';
  int _charIndex = 0;
  Timer? _typingTimer;
  Timer? _pauseTimer;

  int activeOverlayIndex = -1;

  String _selectedCategory = 'All Products';
  String _selectedSort = 'Featured';

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _toggleWishlist(Map<String, dynamic> item) {
    setState(() {
      if (_isInWishlist(item)) {
        wishlist.remove(item);
      } else {
        wishlist.add(item);
      }
    });
  }

  void _startTyping() {
    _typingTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_charIndex < _searchHints[_hintIndex].length) {
        setState(() {
          _currentHint += _searchHints[_hintIndex][_charIndex];
          _charIndex++;
        });
      } else {
        _typingTimer?.cancel();
        _pauseTimer = Timer(const Duration(seconds: 2), () {
          setState(() {
            _hintIndex = (_hintIndex + 1) % _searchHints.length;
            _currentHint = '';
            _charIndex = 0;
          });
          _startTyping();
        });
      }
    });
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _pauseTimer?.cancel();
    super.dispose();
  }

  void _onTabTapped(BuildContext context, int index) {
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/cart');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartService>(context); // ✅ Watch cart updates
    final List<Map<String, dynamic>> allFreshArrivals = [
      {
        'image': 'assets/images/fa2.jpg',
        'brand': 'H&M',
        'title': 'Regular Fit Cashmere jumper',
        'price': 3199,
        'original': 7999,
        'discount': '60% OFF',
        'category': 'Men',
        'id': 1
      },
      {
        'image': 'assets/images/fa1.jpg',
        'brand': 'Zara',
        'title': 'Eco Cotton Shirt Dress',
        'price': 2799,
        'original': 6999,
        'discount': '50% OFF',
        'category': 'Women',
        'id': 2
      },
      {
        'image': 'assets/images/fa4.jpg',
        'brand': 'Uniqlo',
        'title': 'Organic Denim Jacket',
        'price': 4599,
        'original': 8599,
        'discount': '47% OFF',
        'category': 'Men',
        'id': 3
      },
      {
        'image': 'assets/images/fa3.jpg',
        'brand': 'H&M',
        'title': 'Sustainable Wrap Skirt',
        'price': 1999,
        'original': 4499,
        'discount': '55% OFF',
        'category': 'Women',
        'id': 4
      },
      {
        'image': 'assets/images/fa5.jpg',
        'brand': 'EcoBag',
        'title': 'Recycled Handbag',
        'price': 1499,
        'original': 2999,
        'discount': '50% OFF',
        'category': 'Accessories',
        'id': 5
      },
      // clothing
      {
        'image': 'assets/images/c1.jpg',
        'brand': 'H&M',
        'title': 'Recycled Handbag',
        'price': 12009,
        'original': 32999,
        'discount': '50% OFF',
        'category': 'Clothing',
        'id': 6
      },
      {
        'image': 'assets/images/c2.jpg',
        'brand': 'EcoBag',
        'title': 'Recycled Handbag',
        'price': 21499,
        'original': 52999,
        'discount': '50% OFF',
        'category': 'Clothing',
        'id': 7
      },
      {
        'image': 'assets/images/c3.jpg',
        'brand': 'EcoBag',
        'title': 'Recycled Handbag',
        'price': 31499,
        'original': 82999,
        'discount': '50% OFF',
        'category': 'Clothing',
        'id': 8
      },
      {
        'image': 'assets/images/c4.jpg',
        'brand': 'EcoBag',
        'title': 'Recycled Handbag',
        'price': 21499,
        'original': 42999,
        'discount': '50% OFF',
        'category': 'Clothing',
        'id': 9
      },
      {
        'image': 'assets/images/c5.jpg',
        'brand': 'EcoBag',
        'title': 'Recycled Handbag',
        'price': 11499,
        'original': 62999,
        'discount': '50% OFF',
        'category': 'Clothing',
        'id': 10
      },
      // accessories
      {
        'image': 'assets/images/a1.jpg',
        'brand': 'H&M',
        'title': 'Recycled Handbag',
        'price': 12009,
        'original': 32999,
        'discount': '50% OFF',
        'category': 'Accessories',
        'id': 11
      },
      {
        'image': 'assets/images/a2.jpg',
        'brand': 'EcoBag',
        'title': 'Recycled Handbag',
        'price': 21499,
        'original': 52999,
        'discount': '50% OFF',
        'category': 'Accessories',
        'id': 12
      },
      {
        'image': 'assets/images/a3.jpg',
        'brand': 'EcoBag',
        'title': 'Recycled Handbag',
        'price': 31499,
        'original': 82999,
        'discount': '50% OFF',
        'category': 'Accessories',
        'id': 13
      },
      {
        'image': 'assets/images/a4.jpg',
        'brand': 'EcoBag',
        'title': 'Recycled Handbag',
        'price': 21499,
        'original': 42999,
        'discount': '50% OFF',
        'category': 'Accessories',
        'id': 14
      },
      {
        'image': 'assets/images/a5.jpg',
        'brand': 'EcoBag',
        'title': 'Recycled Handbag',
        'price': 11499,
        'original': 62999,
        'discount': '50% OFF',
        'category': 'Accessories',
        'id': 15
      },
      // Footwear
      {
        'image': 'assets/images/s1.jpg',
        'brand': 'H&M',
        'title': 'Recycled Handbag',
        'price': 12009,
        'original': 32999,
        'discount': '50% OFF',
        'category': 'Footwear',
        'id': 16
      },
      {
        'image': 'assets/images/s2.jpg',
        'brand': 'EcoBag',
        'title': 'Recycled Handbag',
        'price': 21499,
        'original': 52999,
        'discount': '50% OFF',
        'category': 'Footwear',
        'id': 17
      },
      {
        'image': 'assets/images/s3.jpg',
        'brand': 'EcoBag',
        'title': 'Recycled Handbag',
        'price': 31499,
        'original': 82999,
        'discount': '50% OFF',
        'category': 'Footwear',
        'id': 18
      },
      {
        'image': 'assets/images/s4.jpg',
        'brand': 'EcoBag',
        'title': 'Recycled Handbag',
        'price': 21499,
        'original': 42999,
        'discount': '50% OFF',
        'category': 'Footwear',
        'id': 19
      },
      {
        'image': 'assets/images/s5.jpg',
        'brand': 'EcoBag',
        'title': 'Recycled Handbag',
        'price': 11499,
        'original': 62999,
        'discount': '50% OFF',
        'category': 'Footwear',
        'id': 20
      },
      // Bags
      {
        'image': 'assets/images/b1.jpg',
        'brand': 'H&M',
        'title': 'Recycled Handbag',
        'price': 12009,
        'original': 32999,
        'discount': '50% OFF',
        'category': 'Bags',
        'id': 21
      },
      {
        'image': 'assets/images/b2.jpg',
        'brand': 'EcoBag',
        'title': 'Recycled Handbag',
        'price': 21499,
        'original': 52999,
        'discount': '50% OFF',
        'category': 'Bags',
        'id': 22
      },
      {
        'image': 'assets/images/b3.jpg',
        'brand': 'EcoBag',
        'title': 'Recycled Handbag',
        'price': 31499,
        'original': 82999,
        'discount': '50% OFF',
        'category': 'Bags',
        'id': 23
      },
      {
        'image': 'assets/images/b4.jpg',
        'brand': 'EcoBag',
        'title': 'Recycled Handbag',
        'price': 21499,
        'original': 42999,
        'discount': '50% OFF',
        'category': 'Bags',
        'id': 24
      },
      {
        'image': 'assets/images/b5.jpg',
        'brand': 'EcoBag',
        'title': 'Recycled Handbag',
        'price': 11499,
        'original': 62999,
        'discount': '50% OFF',
        'category': 'Bags',
        'id': 25
      },
    ];

    List<Map<String, dynamic>> filteredArrivals = allFreshArrivals
        .where((item) =>
            _selectedCategory == 'All Products' ||
            item['category'] == _selectedCategory)
        .toList();

    if (_selectedSort == 'Price: Low to High') {
      filteredArrivals.sort((a, b) => a['price'].compareTo(b['price']));
    } else if (_selectedSort == 'Newest') {
      filteredArrivals.shuffle();
    } else if (_selectedSort == 'Best Sellers') {
      filteredArrivals = filteredArrivals.reversed.toList();
    }
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Image.asset('assets/images/logo.png', height: 40),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const WishlistPage()),
                );
              },
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  const Icon(Icons.favorite_outline, color: Colors.white, size: 28),
                  if (WishlistService().count > 0)
                    Positioned(
                      right: 0,
                      top: -4,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(minWidth: 10, minHeight: 10),
                        child: Text(
                          '${WishlistService().count}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],

      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: -1,
        onTap: (index) => _onTabTapped(context, index),
        isMarketplace: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/background.png', fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.6)),
          ),
          SafeArea(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                if (activeOverlayIndex != -1) {
                  setState(() => activeOverlayIndex = -1);
                }
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: _currentHint,
                                hintStyle: const TextStyle(color: Colors.white70),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          const Icon(Icons.search, color: Colors.white),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _TapOverlayCard(
                      index: 0,
                      isActive: activeOverlayIndex == 0,
                      isAnyOverlayActive: activeOverlayIndex != -1,
                      onToggle: () {
                        setState(() {
                          activeOverlayIndex = activeOverlayIndex == 0 ? -1 : 0;
                        });
                      },
                      imagePath: 'assets/images/mens-collection.jpg',
                      title: "Men's Collection",
                      subtitle: "Discover the latest in men's sustainable fashion",
                    ),
                    const SizedBox(height: 20),
                    _TapOverlayCard(
                      index: 1,
                      isActive: activeOverlayIndex == 1,
                      isAnyOverlayActive: activeOverlayIndex != -1,
                      onToggle: () {
                        setState(() {
                          activeOverlayIndex = activeOverlayIndex == 1 ? -1 : 1;
                        });
                      },
                      imagePath: 'assets/images/womens-collection.jpg',
                      title: "Women's Collection",
                      subtitle: "Explore exclusive women's sustainable fashion",
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: _styledDropdown(
                            value: _selectedCategory,
                            items: ['All Products', 'Accessories', 'Clothing', 'Footwear', 'Bags'],
                            onChanged: (val) {
                              if (val != null) {
                                setState(() => _selectedCategory = val);
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _styledDropdown(
                            value: _selectedSort,
                            items: ['Featured', 'Newest', 'Best Sellers', 'Price: Low to High'],
                            onChanged: (val) {
                              if (val != null) {
                                setState(() => _selectedSort = val);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Fresh Arrivals',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    SizedBox(
                      height: 360,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: filteredArrivals.length,
                        itemBuilder: (context, index) {
                          final item = filteredArrivals[index];
                          return Container(
                            width: 220,
                            margin: const EdgeInsets.only(right: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1C1C1E),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                      child: Image.asset(
                                        item['image'], // instead of 'assets/images/men.png'
                                        width: double.infinity,
                                        height: 180,
                                        fit: BoxFit.cover,
                                      ),

                                    ),
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: GestureDetector(
                                        onTap: () => _toggleWishlist(item),
                                        child: Icon(
                                          _isInWishlist(item) ? Icons.favorite : Icons.favorite_border,
                                          color: _isInWishlist(item) ? Colors.red : Colors.white,
                                        ),
                                      ),
                                    ),


                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item['brand'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                                      const SizedBox(height: 4),
                                      Text(item['title'], style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.2)),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Rs. ${item['price']}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                                          Text(item['discount'], style: const TextStyle(color: Color(0xFF9333EA), fontWeight: FontWeight.bold, fontSize: 14)),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text('Rs. ${item['original']}', style: const TextStyle(color: Colors.white54, fontSize: 13, decoration: TextDecoration.lineThrough)),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(vertical: 8),
                                              decoration: BoxDecoration(
                                                gradient: const RadialGradient(
                                                  center: Alignment(0.08, 0.08),
                                                  radius: 7.98,
                                                  colors: [
                                                    Color.fromRGBO(0, 0, 0, 0.8),
                                                    Color.fromRGBO(147, 51, 234, 0.4),
                                                  ],
                                                  stops: [0.0, 0.5],
                                                ),
                                                borderRadius: BorderRadius.circular(16),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Color(0x66000000),
                                                    offset: Offset(0, 4),
                                                    blurRadius: 4,
                                                  ),
                                                ],
                                              ),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (_) => BuyNowPage(item: item),
                                                    ),
                                                  );
                                                },
                                                child: const Center(
                                                  child: Text(
                                                    'Buy Now',
                                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                                                  ),
                                                ),
                                              ),

                                            ),
                                          ),
                                          const SizedBox(width: 10),

                                          // <-- ONLY change: add onTap that adds to cartItems and SnackBar
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
  cart.add(item); // ✅ Uses CartService for reactive update
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.white, // ✅ white box
      content: Text(
        '${item['title']} added to cart',
        style: const TextStyle(color: Colors.black),
      ),
      duration: const Duration(seconds: 1),
    ),
  );
},
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(18),
                                                  gradient: const LinearGradient(
                                                    colors: [Color(0xFF9333EA), Color(0xFF6B21A8)],
                                                  ),
                                                ),
                                                padding: const EdgeInsets.all(1.5), // border thickness
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: const Color(0xFF1C1C1E), // match your card's background to blend in
                                                    borderRadius: BorderRadius.circular(17),
                                                  ),
                                                  child: const Center(
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(vertical: 8),
                                                      child: Text(
                                                        'Add to Cart',
                                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),


                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    // Insert this AFTER the 'Fresh Arrivals' section in the Column
// Right after the SizedBox(height: 16), that wraps the Fresh Arrivals ListView


                    const SizedBox(height: 16),

// === New Section: Big Savings For You ===
                    Text(
                      'Big Savings For You',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 0.75,
                      children: List.generate(4, (index) {
                        final products = [
                          {
                            'image': 'assets/images/savings1.jpg',
                            'discount': '67% off',
                            'deal': 'Limited time'
                          },
                          {
                            'image': 'assets/images/savings2.jpg',
                            'discount': '80% off',
                            'deal': 'Limited time'
                          },
                          {
                            'image': 'assets/images/savings3.jpg',
                            'discount': '60% off',
                            'deal': 'Limited time'
                          },
                          {
                            'image': 'assets/images/savings4.jpg',
                            'discount': '68% off',
                            'deal': 'Limited time'
                          },
                        ];
                        return Container(

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Image.asset(
                                    products[index]['image']!,
                                    width: double.infinity,
                                    height: 160,
                                    fit: BoxFit.cover,
                                  ),

                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),

                                color: Colors.black.withOpacity(0.3), // still used for background blending
                                child: Row(
                                  children: [
                                    // Purple gradient badge for discount
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [Color(0xFF9333EA), Color(0xFF6B21A8)],
                                        ),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        products[index]['discount']!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 11, // Reduced font size
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    // Plain text for deal
                                    Expanded(
                                      child: Text(
                                        products[index]['deal']!,

                                        style: const TextStyle(
                                          color: Colors.deepPurple, // No background
                                          fontSize: 11, // Reduced font size
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );


                      }),
                    ),


// Also make sure to add the corresponding image assets:
// savings1.png, savings2.png, savings3.png, savings4.png

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _styledDropdown({
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: DropdownButton<String>(
        value: value,
        dropdownColor: Colors.black87,
        underline: const SizedBox(),
        icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
        style: const TextStyle(color: Colors.white),
        isExpanded: true,
        onChanged: onChanged,
        items: items
            .map((item) => DropdownMenuItem<String>(
          value: item,
          child: Text(item, style: const TextStyle(color: Colors.white)),
        ))
            .toList(),
      ),
    );
  }
}

class _TapOverlayCard extends StatelessWidget {
  final int index;
  final bool isActive;
  final bool isAnyOverlayActive;
  final VoidCallback onToggle;
  final String imagePath;
  final String title;
  final String subtitle;

  const _TapOverlayCard({
    required this.index,
    required this.isActive,
    required this.isAnyOverlayActive,
    required this.onToggle,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isActive) onToggle(); // Show overlay only
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Image.asset(imagePath, width: double.infinity, height: 280, fit: BoxFit.cover),
            Container(
              width: double.infinity,
              height: 280,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                ),
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 4),
                    Text(subtitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        )),
                  ],
                ),
              ),
            ),
            if (isActive)
              AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  width: double.infinity,
                  height: 280,
                  color: Colors.black.withOpacity(0.3),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 5,),
                          for (final text in ['Shop All', 'Clothing', 'Footwear', 'Bags', 'Accessories']) ...[
                            _glassButton(context, text),
                            const SizedBox(height: 5),
                          ]
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

  Widget _glassButton(BuildContext context, String text) {
    return GestureDetector(
        onTap: () {
          if (isActive) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CategoryPage(
                  title: '$title - $text',
                  categoryKey: text.toLowerCase(),
                  type: 'sustainable', // or 'luxury' based on page context
                  gender: title.toLowerCase().contains("women") ? 'women' : 'men',
                ),

              ),
            );
          }
        },

        child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.25)),
            ),
            child: Text(text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                )),
          ),
        ),
      ),
    );
  }
}