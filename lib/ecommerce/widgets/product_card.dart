import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lit/global_data.dart';
import 'package:lit/ecommerce/wishlist_service.dart';
import 'package:lit/ecommerce/product_detail_page.dart'; // ✅ make sure this file exists

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final VoidCallback onBuyNow;
  final VoidCallback? onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    required this.onBuyNow,
    this.onAddToCart,
  });

  void addToCart(BuildContext context, Map<String, dynamic> product) {
    cartItems.add(product);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Item added to cart')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /// ✅ Navigate to Product Details Page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE + Wishlist Icon
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Image.asset(
                    product['image'],
                    width: double.infinity,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),

                /// ❤️ Wishlist toggle
                Positioned(
                  top: 10,
                  right: 10,
                  child: Consumer<WishlistService>(
                    builder: (context, wishlist, child) {
                      final isFav = wishlist.contains(product);
                      return GestureDetector(
                        onTap: () {
                          wishlist.toggleWishlist(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                isFav
                                    ? 'Removed from Wishlist'
                                    : 'Added to Wishlist',
                              ),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        child: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? Colors.redAccent : Colors.white,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            // PRODUCT INFO
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Brand
                  Text(
                    product['brand'],
                    style: const TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3),

                  // Title
                  Text(
                    product['title'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),

                  // Price + Discount
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rs. ${product['price']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        product['discount'] ?? '',
                        style: const TextStyle(
                          color: Color(0xFF9333EA),
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),

                  // Original Price
                  Text(
                    'Rs. ${product['original']}',
                    style: const TextStyle(
                      color: Colors.white38,
                      fontSize: 12,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // BUTTONS
                  Row(
                    children: [
                      // Buy Now
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          decoration: BoxDecoration(
                            gradient: const RadialGradient(
                              center: Alignment(0.08, 0.08),
                              radius: 4.98,
                              colors: [
                                Color.fromRGBO(0, 0, 0, 0.8),
                                Color.fromRGBO(147, 51, 234, 0.4),
                              ],
                              stops: [0.0, 0.5],
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: GestureDetector(
                            onTap: onBuyNow,
                            child: const Center(
                              child: Text(
                                'Buy Now',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Add to Cart
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF9333EA), Color(0xFF6B21A8)],
                            ),
                          ),
                          padding: const EdgeInsets.all(1.2),
                          child: GestureDetector(
                            onTap: onAddToCart ??
                                () => addToCart(context, product),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF1C1C1E),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 6),
                                  child: Text(
                                    'Add to Cart',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
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
      ),
    );
  }
}
