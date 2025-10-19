import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cart_provider.dart'; // untuk akses CartItem

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

  /// Convert Purchase ke Map (untuk simpan ke SharedPreferences)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'items': items.map((item) => item.toMap()).toList(),
      'total': total,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  /// Convert Map ke Purchase (saat load dari SharedPreferences)
  factory Purchase.fromMap(Map<String, dynamic> map) {
    return Purchase(
      id: map['id'],
      items: (map['items'] as List)
          .map((itemMap) => CartItem.fromMap(itemMap))
          .toList(),
      total: (map['total'] as num).toDouble(),
      dateTime: DateTime.parse(map['dateTime']),
    );
  }
}

class PurchaseProvider extends ChangeNotifier {
  final List<Purchase> _purchases = [];
  List<Purchase> get purchases => List.unmodifiable(_purchases);

  /// Key untuk SharedPreferences
  static const String _prefsKey = 'purchase_history';

  PurchaseProvider() {
    _loadPurchases();
  }

  void addPurchase(List<CartItem> items) async {
    final purchase = Purchase(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      items: List.from(items),
      total: items.fold(0, (sum, item) => sum + item.totalPrice),
      dateTime: DateTime.now(),
    );

    _purchases.add(purchase);
    notifyListeners();
    await _savePurchases();
  }

  /// Simpan list pembelian ke SharedPreferences dalam bentuk JSON
  Future<void> _savePurchases() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = _purchases.map((p) => p.toMap()).toList();
    final jsonString = jsonEncode(jsonList);
    await prefs.setString(_prefsKey, jsonString);
  }

  /// Load list pembelian saat provider diinisialisasi
  Future<void> _loadPurchases() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_prefsKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      _purchases.clear();
      _purchases.addAll(
        jsonList.map((data) => Purchase.fromMap(data)).toList(),
      );
      notifyListeners();
    }
  }

  /// Optional: untuk clear semua riwayat
  Future<void> clearHistory() async {
    _purchases.clear();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prefsKey);
  }
}
