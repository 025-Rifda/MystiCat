// Base class untuk semua produk menggunakan konsep Inheritance & Abstraction
import 'makanan.dart';
import 'mainan.dart';
import 'aksesoris.dart';
import 'adopsi.dart';

abstract class Produk {
  final String id;
  final String name;
  final String description;
  final DateTime createdAt;
  final double rating;
  final String imagePath;

  Produk({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    this.rating = 0.0,
  }) : createdAt = DateTime.now();

  // Abstract method wajib diimplementasikan subclass
  String getInfo();

  // Abstract getters for price
  double get price;
  String getFormattedPrice();

  // Method umum
  String getBasicInfo() {
    return 'ID: $id | Dibuat: ${createdAt.toString().split(' ')[0]}';
  }

  String getCategory() => "Produk Umum";

  @override
  String toString() => 'Produk($name)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Produk && other.id == id);

  @override
  int get hashCode => id.hashCode;

  // --- ✨ Bagian penting untuk SharedPreferences ---

  /// Konversi ke Map untuk disimpan
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imagePath': imagePath,
      'rating': rating,
      'createdAt': createdAt.toIso8601String(),
      'type': getCategory(), // penting untuk identifikasi subclass saat decode
      'price': price,
    };
  }

  /// Factory untuk decode dari Map
  /// Catatan: ini butuh tahu type-nya untuk arahkan ke subclass yang tepat
  static Produk fromMap(Map<String, dynamic> map) {
    final type = map['type'];
    switch (type) {
      case 'Makanan':
        return Makanan.fromMap(map);
      case 'Mainan':
        return Mainan.fromMap(map);
      case 'Aksesoris':
        return Aksesoris.fromMap(map);
      case 'Adopsi':
        return Adopsi.fromMap(map);
      // Tambah tipe lain jika ada
      default:
        throw Exception('Unknown product type: $type');
    }
  }
}
