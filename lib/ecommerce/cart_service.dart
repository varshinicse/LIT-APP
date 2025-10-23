import 'package:flutter/foundation.dart';

class CartService extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => List.unmodifiable(_items);

  int get count => _items.length;

  double get totalPrice =>
      _items.fold(0, (sum, item) => sum + (item['price'] ?? 0));

  /// Add an item to the cart
  void add(Map<String, dynamic> product) {
    // Avoid duplicates by product ID if available
    if (!_items.any((item) => item['id'] == product['id'])) {
      _items.add(product);
      notifyListeners();
    }
  }

  /// Remove an item from the cart
  void remove(Map<String, dynamic> product) {
    _items.removeWhere((item) => item['id'] == product['id']);
    notifyListeners();
  }

  /// Clear the entire cart
  void clear() {
    _items.clear();
    notifyListeners();
  }

  /// Check if product is already in cart
  bool contains(Map<String, dynamic> product) {
    return _items.any((item) => item['id'] == product['id']);
  }
}
