import 'package:flutter/material.dart';

class WishlistService extends ChangeNotifier {
  static final WishlistService _instance = WishlistService._internal();

  factory WishlistService() => _instance;

  WishlistService._internal();

  final List<Map<String, dynamic>> _wishlist = [];

  List<Map<String, dynamic>> get items => _wishlist;

  void add(Map<String, dynamic> item) {
    if (!_wishlist.any((e) => e['id'] == item['id'])) {
      _wishlist.add(item);
      notifyListeners();
    }
  }

  void remove(Map<String, dynamic> item) {
    _wishlist.removeWhere((e) => e['id'] == item['id']);
    notifyListeners();
  }

  bool contains(Map<String, dynamic> item) {
    return _wishlist.any((e) => e['id'] == item['id']);
  }

  int get count => _wishlist.length;

  /// ✅ Toggle function (add if not exists, remove if exists)
  void toggleWishlist(Map<String, dynamic> item) {
    if (contains(item)) {
      remove(item);
    } else {
      add(item);
    }
  }
}
