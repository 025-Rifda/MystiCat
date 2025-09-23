import 'package:intl/intl.dart';
import 'package:flutter_application_1/model/Produk.dart';

// Makanan class menggunakan konsep Inheritance dari Produk
class Makanan extends Produk {
  // Encapsulation: private fields
  final double _price;
  final String _jenis;
  final String _brand;
  int _stok; // tidak pakai final agar bisa diubah lewat setter

  // Constructor
  Makanan({
    required super.id,
    required super.name,
    required super.description,
    required super.imagePath,
    required double price,
    required String jenis,
    String brand = '',
    int stok = 0,
    super.rating = 0.0,
  }) : _price = price,
       _jenis = jenis,
       _brand = brand,
       _stok = stok;

  // Getter methods (Encapsulation)
  @override
  double get price => _price;

  // Removed duplicate getFormattedPrice method
  String get jenis => _jenis;
  String get brand => _brand;
  int get stok => _stok;

  // Setter untuk stok (Encapsulation)
  set stok(int value) {
    if (value >= 0) {
      print('Stok makanan ${this.name} diubah dari $_stok menjadi $value');
      _stok = value;
    }
  }

  // Polymorphism: implementasi getInfo() method
  @override
  String getInfo() {
    return 'Harga: ${getFormattedPrice()} | Jenis: $_jenis | Brand: $_brand | Stok: $_stok';
  }

  // Override kategori produk
  @override
  String getCategory() => "Makanan Kucing";

  // Method khusus untuk makanan
  bool isAvailable() => _stok > 0;

  String getFormattedPrice() {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
    return formatter.format(_price);
  }

  // Static method untuk sample data
  static List<Makanan> get sampleData => [
    Makanan(
      id: 'M001',
      name: 'Whiskas Tuna',
      description: 'Makanan kucing rasa tuna premium',
      imagePath: 'assets/makanan/tuna.png',
      price: 15000,
      jenis: 'Kering',
      brand: 'Whiskas',
      stok: 25,
      rating: 4.8,
    ),
    Makanan(
      id: 'M002',
      name: 'Royal Canin Mother & Babycat',
      description: 'Makanan khusus induk menyusui dan anak kucing',
      imagePath: 'assets/makanan/motherbaby.png',
      price: 48000,
      jenis: 'Kering',
      brand: 'Royal Canin',
      stok: 18,
      rating: 4.9,
    ),
    Makanan(
      id: 'M003',
      name: 'Sheba Tuna Fillet',
      description: 'Makanan basah potongan tuna asli',
      imagePath: 'assets/makanan/sheba.png',
      price: 13000,
      jenis: 'Basah',
      brand: 'Sheba',
      stok: 28,
      rating: 4.6,
    ),
    Makanan(
      id: 'M004',
      name: 'Purina Pro Plan Adult',
      description: 'Makanan kucing dewasa dengan formula sehat',
      imagePath: 'assets/makanan/Purina.png',
      price: 36000,
      jenis: 'Kering',
      brand: 'Purina',
      stok: 22,
      rating: 4.7,
    ),
    Makanan(
      id: 'M005',
      name: 'Felix Pouch Tuna & Salmon',
      description: 'Makanan basah pouch campuran tuna dan salmon',
      imagePath: 'assets/makanan/Felix.png',
      price: 8500,
      jenis: 'Basah',
      brand: 'Felix',
      stok: 42,
      rating: 4.5,
    ),
    Makanan(
      id: 'M006',
      name: 'Whiskas Ocean Fish',
      description: 'Makanan kering rasa ikan laut untuk kesehatan bulu',
      imagePath: 'assets/makanan/fish.png',
      price: 56000,
      jenis: 'Kering',
      brand: 'Whiskas',
      stok: 20,
      rating: 4.7,
    ),
    Makanan(
      id: 'M007',
      name: 'Royal Canin Hairball Care',
      description: 'Makanan kering khusus kucing dewasa anti hairball',
      imagePath: 'assets/makanan/hairball.png',
      price: 125000,
      jenis: 'Kering',
      brand: 'Royal Canin',
      stok: 14,
      rating: 4.9,
    ),
    Makanan(
      id: 'M008',
      name: 'Me-O Creamy Treats Salmon',
      description: 'Snack creamy rasa salmon, cocok untuk reward',
      imagePath: 'assets/makanan/Me-O .png',
      price: 26000,
      jenis: 'Snack',
      brand: 'Me-O',
      stok: 52,
      rating: 4.6,
    ),
  ];
}
