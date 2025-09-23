import 'package:flutter/material.dart';
import 'cart_provider.dart'; // biar bisa akses CartItem

class Purchase {
  final String id;
  final List<CartItem> items;
  final double total;
  final DateTime dateTime;

  Purchase({
    required this.id,
    required this.items,
    required this.total,
    required this.dateTime,
  });
}

class PurchaseProvider extends ChangeNotifier {
  final List<Purchase> _purchases = [];

  List<Purchase> get purchases => List.unmodifiable(_purchases);

  void addPurchase(List<CartItem> items) {
    final purchase = Purchase(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      items: List.from(items),
      total: items.fold(0, (sum, item) => sum + item.totalPrice),
      dateTime: DateTime.now(),
    );
    _purchases.add(purchase);
    notifyListeners();
  }
}
