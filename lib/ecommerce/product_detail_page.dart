// lib/ecommerce/product_detail_page.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:lit/ecommerce/wishlist_service.dart';
import 'package:lit/global_data.dart';
import 'package:lit/pages/notifications_page.dart';
import 'package:lit/ecommerce/cart_page.dart';
import 'package:lit/ecommerce/wishlist_page.dart';
import 'package:lit/widgets/app_drawer.dart';

/// Main radial gradient reused across UI
const RadialGradient sustainableGradient = RadialGradient(
  center: Alignment(0.08, 0.08),
  radius: 7.98,
  colors: [
    Color.fromRGBO(0, 0, 0, 0.8), // Deep black base
    Color.fromRGBO(147, 51, 234, 0.4), // Soft purple accent
  ],
  stops: [0.0, 0.5],
);

class ProductDetailPage extends StatefulWidget {
  final Map<String, dynamic> product;
  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  String? selectedSize;
  final TextEditingController _pincodeController = TextEditingController();
  final GlobalKey<FormState> _pincodeFormKey = GlobalKey<FormState>();
  final TextEditingController _reviewController = TextEditingController();

  // sample rating counts for bars
  final List<int> _ratingCounts = [286, 286, 0, 0, 0];

  @override
  void dispose() {
    _pincodeController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  void addToCart() {
    cartItems.add(widget.product);
    setState(() {});
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Item added to bag")));
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final wishlist = Provider.of<WishlistService>(context);
    final wishlistCount = wishlist.items.length;
    final cartCount = cartItems.length;

    final ratingDouble =
        (product['rating'] is num) ? (product['rating'] as num).toDouble() : 4.5;
    final ratingCount = product['ratingCount'] ?? 572;
    final ratingText = "${ratingDouble.toStringAsFixed(1)} ($ratingCount)";

    return Scaffold(
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          // background image and dark overlay
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
              errorBuilder: (ctx, err, st) => Container(color: Colors.black),
            ),
          ),
          Positioned.fill(child: Container(color: Colors.black.withOpacity(0.6))),

          SafeArea(
            bottom: false,
            child: Column(
              children: [
                // Header 1: menu - logo - notification
                _buildTopHeader(context),

                // Header 2: Back - wishlist/cart icons
                _buildSubHeader(context, wishlistCount, cartCount),

                // Main content
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildProductImage(product),
                        const SizedBox(height: 12),
                        _buildProductInfo(product, ratingText),
                        const SizedBox(height: 14),
                        _buildWishlistAndAddToBag(context, wishlist, product),
                        const SizedBox(height: 20),
                        _buildSizeSection(),
                        const SizedBox(height: 18),
                        ExpandableSection(
                          title: "Product Description",
                          initiallyExpanded: false,
                          child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: _buildProductDescription()),
                        ),
                        const SizedBox(height: 12),
                        ExpandableSection(
                          title: "Delivery & Return Information",
                          initiallyExpanded: false,
                          child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: _buildDeliveryWithPincode()),
                        ),
                        const SizedBox(height: 12),
                        _buildShareRow(),
                        const SizedBox(height: 18),
                        _buildRateAndReviewArea(),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Top header: menu, logo, notifications
  Widget _buildTopHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/images/logo.png',
                height: 40,
                errorBuilder: (ctx, err, st) => const SizedBox(),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationsPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  // Sub header: back & small icons
  Widget _buildSubHeader(BuildContext context, int wishlistCount, int cartCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back — arrow white, text purple
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Row(
              children: const [
                Icon(Icons.arrow_back_ios, color: Colors.white),
                SizedBox(width: 6),
                Text("Back",
                    style: TextStyle(
                        color: Color(0xFFB794F4),
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          Row(
            children: [
              Stack(
                children: [
                  IconButton(
                      icon: const Icon(Icons.favorite_border, color: Colors.white),
                      onPressed: () async {
                        await Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const WishlistPage()));
                        setState(() {});
                      }),
                  if (wishlistCount > 0)
                    Positioned(right: 8, top: 8, child: _buildBadge(wishlistCount)),
                ],
              ),
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
                    onPressed: () async {
                      await Navigator.push(
                          context, MaterialPageRoute(builder: (context) => CartPage(cartItems: cartItems)));
                      setState(() {});
                    },
                  ),
                  if (cartCount > 0) Positioned(right: 8, top: 8, child: _buildBadge(cartCount)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Product image with rounded corners
  Widget _buildProductImage(Map<String, dynamic> product) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        product['image'],
        width: double.infinity,
        height: 360,
        fit: BoxFit.cover,
        errorBuilder: (ctx, err, st) => Container(height: 360, color: Colors.grey[800]),
      ),
    );
  }

  Widget _buildBadge(int count) {
    return Container(
      height: 14,
      width: 14,
      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
      child: Center(
        child: Text('$count',
            style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
      ),
    );
  }

  // Product title/brand + rating on same row
  Widget _buildProductInfo(Map<String, dynamic> product, String ratingText) {
    final brand = product['brand'] ?? '';
    final title = product['title'] ?? '';
    final price = product['price'] ?? '';
    final discount = product['discount'] ?? '';
    final original = product['original'] ?? '';

    final ratingNumeric = ratingText.split(' ').first;
    final ratingRest = ratingText.substring(ratingNumeric.length);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: brand,
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                TextSpan(
                    text: " $title",
                    style: const TextStyle(color: Colors.white70, fontSize: 15, fontWeight: FontWeight.w400)),
              ]),
            ),
          ),
          Row(children: [
            const Icon(Icons.star, color: Color(0xFF9333EA), size: 18),
            const SizedBox(width: 4),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: ratingNumeric,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
                TextSpan(text: ratingRest, style: const TextStyle(color: Colors.white70, fontSize: 13)),
              ]),
            ),
          ]),
        ]),
        const SizedBox(height: 8),
        Row(children: [
          Text("Rs. $price",
              style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(width: 10),
          Text(discount,
              style: const TextStyle(color: Color(0xFF9333EA), fontSize: 16, fontWeight: FontWeight.bold)),
        ]),
        const SizedBox(height: 4),
        Text("MRP Rs. $original",
            style: const TextStyle(color: Colors.white70, fontSize: 13, decoration: TextDecoration.lineThrough)),
      ]),
    );
  }

  // Wishlist (filled gradient) and Add to Bag (gradient outline)
  Widget _buildWishlistAndAddToBag(BuildContext context, WishlistService wishlist, Map<String, dynamic> product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(children: [
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(gradient: sustainableGradient, borderRadius: BorderRadius.circular(14)),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
              onPressed: () {
                wishlist.toggleWishlist(product);
                setState(() {});
              },
              child: const Text("Wishlist", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: GradientBoxBorder(
                gradient: const LinearGradient(colors: [Color(0xFF9333EA), Color(0xFF7E22CE)]),
                width: 1.6,
              ),
            ),
            child: OutlinedButton.icon(
              icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 18),
              label: const Text("Add to Bag", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
              onPressed: addToCart,
            ),
          ),
        ),
      ]),
    );
  }

  // Size section - single row, outlined boxes - selected gets purple outline
  Widget _buildSizeSection() {
    final sizes = ['XXS', 'XS', 'S', 'M', 'L', 'XL'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
          Text("Select Size", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
          Text("Size chart", style: TextStyle(color: Colors.white70, fontSize: 14)),
        ]),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: sizes.map((size) {
            final isSelected = selectedSize == size;
            return GestureDetector(
              onTap: () => setState(() => selectedSize = size),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                width: 52,
                height: 46,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: isSelected ? const Color(0xFF9333EA) : Colors.white70, width: isSelected ? 2.0 : 1.3),
                ),
                child: Center(child: Text(size, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
              ),
            );
          }).toList(),
        ),
      ]),
    );
  }

  // Product Description inner content
  Widget _buildProductDescription() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Expanded(child: _descItem("Length", "Cropped")),
        const SizedBox(width: 12),
        Expanded(child: _descItem("Neckline", "V-neck")),
      ]),
      const SizedBox(height: 10),
      Row(children: [
        Expanded(child: _descItem("Sleeve Length", "Long sleeve")),
        const SizedBox(width: 12),
        Expanded(child: _descItem("Composition", "Viscose 70%, Polyamide 30%")),
      ]),
      const SizedBox(height: 10),
      _descItem("Fit", "Slim fit"),
    ]);
  }

  Widget _descItem(String title, String value) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(color: Colors.white70, fontSize: 14)),
      const SizedBox(height: 6),
      Text(value, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
    ]);
  }

  // Delivery & pincode UI with gradient background, divider and check button inside box
  Widget _buildDeliveryWithPincode() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        decoration: BoxDecoration(gradient: sustainableGradient, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.white24)),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Form(
          key: _pincodeFormKey,
          child: Row(children: [
            Expanded(
              child: TextFormField(
                controller: _pincodeController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration: const InputDecoration(
                    counterText: '', border: InputBorder.none, hintText: 'Enter a Pincode', hintStyle: TextStyle(color: Colors.white54)),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) return 'Enter pincode';
                  if (!RegExp(r'^\d{6}$').hasMatch(val.trim())) return 'Enter 6 digit PIN';
                  return null;
                },
              ),
            ),
            Container(width: 1, height: 36, color: Colors.white24),
            const SizedBox(width: 8),
            TextButton(
              onPressed: () {
                final ok = _pincodeFormKey.currentState?.validate() ?? false;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ok ? "Delivery available for this PIN" : "Please enter a valid 6-digit PIN")));
              },
              style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12), backgroundColor: Colors.transparent),
              child: const Text('CHECK', style: TextStyle(color: Color(0xFFB794F4), fontWeight: FontWeight.w700)),
            ),
          ]),
        ),
      ),
      const SizedBox(height: 12),
      const Text(
        "Please enter the PIN code to check if delivery is available. Return and Exchange will be available for 7 days from the date of order of delivery.",
        style: TextStyle(color: Colors.white70, fontSize: 13),
      ),
    ]);
  }

  // Share row using assets; fallback to icon if missing
  Widget _buildShareRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text("Share", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Row(children: [
          _assetIcon('assets/images/logos_pinterest.png'),
          const SizedBox(width: 12),
          _assetIcon('assets/images/logos_facebook.png'),
          const SizedBox(width: 12),
          _assetIcon('assets/images/fa6-brands_square-x-twitter.png'),
          const SizedBox(width: 12),
          _assetIcon('assets/images/logos_whatsapp-icon.png'),
          const SizedBox(width: 12),
          _assetIcon('assets/images/skill-icons_instagram.png'),
        ]),
      ]),
    );
  }

  Widget _assetIcon(String path) {
    return Container(
      width: 44,
      height: 44,
      decoration: const BoxDecoration(color: Colors.transparent, shape: BoxShape.circle),
      child: Center(
        child: Image.asset(
          path,
          width: 34,
          height: 34,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            // fallback so missing asset won't crash
            return const Icon(Icons.share, color: Colors.white, size: 20);
          },
        ),
      ),
    );
  }

  // Rate & Review area with bars and Write Review button
  Widget _buildRateAndReviewArea() {
    final total = _ratingCounts.fold<int>(0, (s, e) => s + e);
    final fractions = _ratingCounts.map((c) => total == 0 ? 0.0 : c / total).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text("Rate & Review", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Row(children: [
          const Icon(Icons.star, color: Color(0xFF9333EA), size: 22),
          const SizedBox(width: 8),
          const Text("4.5", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          const Text("572 Verified Buyer Rating", style: TextStyle(color: Colors.white70)),
        ]),
        const SizedBox(height: 12),
        Column(children: List.generate(5, (i) {
          final star = 5 - i;
          final count = _ratingCounts[i];
          final frac = fractions[i];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Row(children: [
              Icon(Icons.star, size: 14, color: star >= 4 ? const Color(0xFF9333EA) : Colors.white54),
              const SizedBox(width: 6),
              Text('$star', style: const TextStyle(color: Colors.white70)),
              const SizedBox(width: 10),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(value: frac, minHeight: 10, backgroundColor: Colors.white24, valueColor: const AlwaysStoppedAnimation(Color(0xFF9333EA))),
                ),
              ),
              const SizedBox(width: 10),
              Text('$count', style: const TextStyle(color: Colors.white70)),
            ]),
          );
        })),
        const SizedBox(height: 12),

        // WRITE A PRODUCT REVIEW button now uses sustainableGradient background (requested change)
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: sustainableGradient, // <- updated to use sustainableGradient
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white24),
          ),
          child: TextButton(
            onPressed: _openWriteReviewDialog,
            style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
            child: const Text("WRITE A PRODUCT REVIEW", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
      ]),
    );
  }

  // Review dialog with blur behind and only input placeholder visible
  void _openWriteReviewDialog() {
    _reviewController.clear();
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "Write Review",
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return GestureDetector(
          onTap: () => Navigator.of(context).maybePop(),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.02), // subtle dark translucent backing inside blur
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  // Title
                  const Text("Write a Review", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),

                  // Only the text area — placeholder "Type your review here..."
                  TextField(
                    controller: _reviewController,
                    maxLines: 6,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Type your review here...",
                      hintStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.25),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white24),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Buttons: Cancel and Submit (submit uses sustainableGradient)
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text("CANCEL", style: TextStyle(color: Colors.white70))),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(gradient: sustainableGradient, borderRadius: BorderRadius.circular(8)),
                      child: ElevatedButton(
                        onPressed: () {
                          final txt = _reviewController.text.trim();
                          if (txt.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please write something first")));
                            return;
                          }
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Review submitted")));
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                        child: const Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), child: Text("SUBMIT")),
                      ),
                    ),
                  ]),
                ]),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// ExpandableSection widget — custom expand/collapse with rounded translucent container
class ExpandableSection extends StatefulWidget {
  final String title;
  final Widget child;
  final bool initiallyExpanded;
  const ExpandableSection({super.key, required this.title, required this.child, this.initiallyExpanded = false});

  @override
  State<ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<ExpandableSection> {
  late bool isExpanded;

  @override
  void initState() {
    super.initState();
    isExpanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.04), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.white10)),
        child: Column(
          children: [
            InkWell(
              onTap: () => setState(() => isExpanded = !isExpanded),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(widget.title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: Colors.white),
                ]),
              ),
            ),
            AnimatedCrossFade(
              firstChild: Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), child: widget.child),
              secondChild: const SizedBox.shrink(),
              crossFadeState: isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 200),
            )
          ],
        ),
      ),
    );
  }
}

/// GradientBoxBorder paints a gradient stroke around a rounded rect.
/// Note: do NOT use const when creating this border in a BoxDecoration.
class GradientBoxBorder extends BoxBorder {
  final Gradient gradient;
  final double width;

  GradientBoxBorder({required this.gradient, this.width = 1.0});

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(width);

  @override
  bool get isUniform => true;

  @override
  BorderSide get top => BorderSide.none;

  @override
  BorderSide get bottom => BorderSide.none;

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection, BoxShape shape = BoxShape.rectangle, BorderRadius? borderRadius}) {
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    if (shape == BoxShape.circle) {
      final radius = rect.shortestSide / 2;
      canvas.drawCircle(rect.center, radius - width / 2, paint);
    } else {
      final rrect = RRect.fromRectAndRadius(rect.deflate(width / 2), borderRadius?.topLeft ?? const Radius.circular(14));
      canvas.drawRRect(rrect, paint);
    }
  }

  @override
  ShapeBorder scale(double t) => GradientBoxBorder(gradient: gradient, width: width * t);
}
