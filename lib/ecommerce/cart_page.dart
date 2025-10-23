import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lit/ecommerce/cart_service.dart';
import 'package:lit/ecommerce/address_page.dart';
import 'package:lit/widgets/app_drawer.dart';
import 'package:lit/widgets/common_button.dart';
import 'package:lit/pages/notifications_page.dart';

class CartPage extends StatefulWidget {
  final List<dynamic> cartItems; // or your model type

  const CartPage({super.key, required this.cartItems});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int currentIndex = 1;
  final List<String> availableSizes = ['XXS', 'XS', 'S', 'M', 'L', 'XL'];

  @override
  Widget build(BuildContext context) {
    final items = widget.cartItems;
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🟣 Top Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(
                      builder: (context) => IconButton(
                        icon: const Icon(Icons.menu, color: Colors.white),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      ),
                    ),
                    Image.asset('assets/images/logo.png', height: 40),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const NotificationsPage(),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // 🟣 Back Option
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    children: const [
                      Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 16),
                      SizedBox(width: 4),
                      Text(
                        "Back",
                        style: TextStyle(
                          color: Color(0xFFB388FF),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
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
            child: Consumer<CartService>(
              builder: (context, cart, child) {
                final cartItems = cart.items;
                final total = cartItems.fold<int>(
                  0,
                  (sum, item) => sum + (item['price'] as int? ?? 0),
                );

                if (cartItems.isEmpty) {
                  return const Center(
                    child: Text(
                      "Your cart is empty",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView(
                    children: [
                      const SizedBox(height: 12),
                      ...cartItems.map((item) => _cartItemCard(context, item, cart)).toList(),
                      const SizedBox(height: 14),
                      const Divider(color: Colors.white),

                      // 🟣 Coupon Section
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Row(
                              children: [
                                Icon(Icons.local_offer_outlined, color: Colors.white, size: 20),
                                SizedBox(width: 10),
                                Text(
                                  'Apply Coupon',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Select',
                              style: TextStyle(
                                color: Color(0xFF7F34C3),
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(color: Colors.white),
                      const SizedBox(height: 10),

                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Order Summary',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      _summaryRow('Cart Total', 'Rs. $total'),
                      _summaryRow('Savings', '-Rs. 900', color: Color(0xFF7F34C3)),
                      _summaryRow('Platform Fee', 'Free'),
                      _summaryRow('Delivery Fee', 'Free'),
                      const Divider(color: Colors.white),
                      _summaryRow('Total Amount', 'Rs. $total', isBold: true, fontSize: 18),
                      const Divider(color: Colors.white),
                      const SizedBox(height: 24),

                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Return & Exchange Policy',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Return and Exchange will be available for 7 days from the date of order of delivery',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomSheet: Consumer<CartService>(
        builder: (context, cart, _) {
          if (cart.items.isEmpty) return const SizedBox.shrink();
          final total = cart.items.fold<int>(
            0,
            (sum, item) => sum + (item['price'] as int? ?? 0),
          );
          return _bottomBuyNow(total, cart.items);
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        isMarketplace: true,
      ),
    );
  }

  // 🟣 Cart Item UI
  Widget _cartItemCard(BuildContext context, Map<String, dynamic> item, CartService cart) {
    String selectedSize = item['selectedSize'] ?? 'M';
    int selectedQty = item['selectedQty'] ?? 1;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
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
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Color(0xFF864AFE), width: 0.8),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              item['image'],
              width: 85,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['brand'],
                    style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text(item['title'], style: const TextStyle(color: Colors.white70, fontSize: 13)),
                const SizedBox(height: 8),

                // 🟣 Size and Qty Buttons
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => _showSizeSelector(context, item),
                      child: _optionBox('Size: $selectedSize'),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => _showQtySelector(context, item),
                      child: _optionBox('Qty: $selectedQty'),
                    ),
                  ],
                ),

                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rs. ${item['price']}',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(item['discount'] ?? '',
                        style: const TextStyle(color: Color(0xFF9333EA), fontWeight: FontWeight.bold, fontSize: 14)),
                  ],
                ),
                if (item['original'] != null)
                  Text(
                    'Rs. ${item['original']}',
                    style: const TextStyle(
                      color: Colors.white38,
                      fontSize: 12,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () => cart.remove(item),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    ),
                    child: const Text('Remove', style: TextStyle(color: Colors.white, fontSize: 13)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _optionBox(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white30),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }

  // 🟣 Size Selector Popup
  void _showSizeSelector(BuildContext context, Map<String, dynamic> item) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (_) {
        String selectedSize = item['selectedSize'] ?? 'M';
        return StatefulBuilder(builder: (context, setModalState) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0.08, 0.08),
                radius: 7.98,
                colors: [
                  Color.fromRGBO(0, 0, 0, 0.8),
                  Color.fromRGBO(147, 51, 234, 0.4),
                ],
                stops: [0.0, 0.5],
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Select Size",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: availableSizes.map((size) {
                      bool isSelected = size == selectedSize;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: GestureDetector(
                          onTap: () {
                            setModalState(() => selectedSize = size);
                            setState(() => item['selectedSize'] = size);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 50,
                            height: 45,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isSelected ? const Color(0xFF9333EA) : Colors.white,
                                width: isSelected ? 2 : 1,
                              ),
                              color: isSelected
                                  ? const Color.fromRGBO(147, 51, 234, 0.2)
                                  : Colors.transparent,
                            ),
                            child: Text(size,
                                style: const TextStyle(
                                    color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20),
                _gradientDoneButton(context),
                const SizedBox(height: 10),
              ],
            ),
          );
        });
      },
    );
  }

  // 🟣 Quantity Selector Popup
  void _showQtySelector(BuildContext context, Map<String, dynamic> item) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (_) {
        return StatefulBuilder(builder: (context, setModalState) {
          int selectedQty = item['selectedQty'] ?? 1;
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0.08, 0.08),
                radius: 7.98,
                colors: [
                  Color.fromRGBO(0, 0, 0, 0.8),
                  Color.fromRGBO(147, 51, 234, 0.4),
                ],
                stops: [0.0, 0.5],
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Select Quantity",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _qtyButton(Icons.remove, () {
                      if (selectedQty > 1) {
                        setModalState(() => selectedQty--);
                        setState(() => item['selectedQty'] = selectedQty);
                      }
                    }),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        '$selectedQty',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    _qtyButton(Icons.add, () {
                      setModalState(() => selectedQty++);
                      setState(() => item['selectedQty'] = selectedQty);
                    }),
                  ],
                ),
                const SizedBox(height: 20),
                _gradientDoneButton(context),
                const SizedBox(height: 10),
              ],
            ),
          );
        });
      },
    );
  }

  // 🟣 Gradient Done Button (matches Sustainable Buy Now)
  Widget _gradientDoneButton(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0.08, 0.08),
          radius: 7.98,
          colors: [
            Color.fromRGBO(0, 0, 0, 0.8),
            Color.fromRGBO(147, 51, 234, 0.4),
          ],
          stops: [0.0, 0.5],
        ),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: ElevatedButton(
        onPressed: () => Navigator.pop(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text("Done",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _qtyButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }

  Widget _bottomBuyNow(int total, List<dynamic> cartItems) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0.08, 0.08),
          radius: 7.98,
          colors: [
            Color.fromRGBO(0, 0, 0, 0.8),
            Color.fromRGBO(147, 51, 234, 0.4),
          ],
          stops: [0.0, 0.5],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'Total Amount\n',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                TextSpan(
                  text: 'Rs.$total',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0.08, 0.08),
                radius: 7.98,
                colors: [
                  Color.fromRGBO(0, 0, 0, 0.8),
                  Color.fromRGBO(147, 51, 234, 0.4),
                ],
                stops: [0.0, 0.5],
              ),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddressPage(
                      cartItems: cartItems.cast<Map<String, dynamic>>(),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
              ),
              child: const Text('Buy Now', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String title, String value,
      {bool isBold = false, double fontSize = 14, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  fontSize: fontSize)),
          Text(
            value,
            style: TextStyle(
              color: color ?? Colors.white,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }
}
