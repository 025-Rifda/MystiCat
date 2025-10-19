import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/model/Produk.dart';

class CartItem {
  final Produk produk;
  int quantity;

  CartItem({required this.produk, this.quantity = 1});

  double get totalPrice => produk.price * quantity;

  Map<String, dynamic> toMap() {
    return {'produk': produk.toMap(), 'quantity': quantity};
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      produk: Produk.fromMap(map['produk']),
      quantity: map['quantity'],
    );
  }
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  CartProvider() {
    _loadCartFromPrefs(); // 🟡 Load data saat provider dibuat
  }

  void addItem(Produk produk, {int quantity = 1}) {
    final index = _items.indexWhere((item) => item.produk.id == produk.id);
    if (index >= 0) {
      _items[index].quantity += quantity;
    } else {
      _items.add(CartItem(produk: produk, quantity: quantity));
    }
    _saveCartToPrefs(); // 📝 Simpan setiap kali ada perubahan
    notifyListeners();
  }

  void removeItem(Produk produk) {
    _items.removeWhere((item) => item.produk.id == produk.id);
    _saveCartToPrefs();
    notifyListeners();
  }

  void clear() {
    _items.clear();
    _saveCartToPrefs();
    notifyListeners();
  }

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice => _items.fold(0, (sum, item) => sum + item.totalPrice);

  // 📝 Simpan ke SharedPreferences
  Future<void> _saveCartToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonItems = _items
        .map((item) => jsonEncode(item.toMap()))
        .toList();
    await prefs.setStringList('cart_items', jsonItems);
  }

  // 📥 Muat dari SharedPreferences
  Future<void> _loadCartFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jsonItems = prefs.getStringList('cart_items');

    if (jsonItems != null) {
      _items.clear();
      _items.addAll(
        jsonItems.map((item) {
          final map = jsonDecode(item);
          return CartItem.fromMap(map);
        }),
      );
      notifyListeners();
    }
  }
}
