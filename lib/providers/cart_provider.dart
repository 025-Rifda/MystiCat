import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/Produk.dart';

class CartItem {
  final Produk produk;
  int quantity;

  CartItem({required this.produk, this.quantity = 1});

  double get totalPrice => produk.price * quantity;
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  void addItem(Produk produk) {
    final index = _items.indexWhere((item) => item.produk.name == produk.name);
    if (index >= 0) {
      // Kalau produk sudah ada, tambah quantity
      _items[index].quantity += 1;
    } else {
      // Kalau produk belum ada, tambahin baru
      _items.add(CartItem(produk: produk));
    }
    notifyListeners();
  }

  void removeItem(Produk produk) {
    _items.removeWhere((item) => item.produk.name == produk.name);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice => _items.fold(0, (sum, item) => sum + item.totalPrice);
}
