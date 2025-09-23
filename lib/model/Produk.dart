// Base class untuk semua produk menggunakan konsep Inheritance & Abstraction
abstract class Produk {
  // Protected fields - bisa diakses oleh subclass
  final String id;
  final String name;
  final String description;
  final DateTime createdAt;
  final double rating;
  final String imagePath;

  // Constructor
  Produk({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    this.rating = 0.0,
  }) : createdAt = DateTime.now();

  // Abstract method → wajib dioverride oleh subclass
  String getInfo();

  // Abstract getters for price and formatted price
  double get price;
  String getFormattedPrice();

  // Method umum untuk semua produk
  String getBasicInfo() {
    return 'ID: $id | Dibuat: ${createdAt.toString().split(' ')[0]}';
  }

  // Optional → bisa dioverride subclass kalau perlu
  String getCategory() => "Produk Umum";

  @override
  String toString() => 'Produk($name)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Produk && other.id == id);

  @override
  int get hashCode => id.hashCode;
}
