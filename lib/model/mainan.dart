import 'package:intl/intl.dart';
import 'package:flutter_application_1/model/Produk.dart';

// Mainan class menggunakan konsep Inheritance dari Produk
class Mainan extends Produk {
  // Encapsulation: private fields
  final double _price;
  final String _material;
  final String _ukuran;
  final String _kategori;

  // Constructor
  Mainan({
    required super.id,
    required super.name,
    required super.description,
    required super.imagePath,
    required double price,
    required String material,
    required String ukuran,
    String kategori = 'Umum',
    super.rating = 0.0,
  }) : _price = price,
       _material = material,
       _ukuran = ukuran,
       _kategori = kategori;

  // Getter methods (Encapsulation)
  @override
  double get price => _price;

  @override
  String getFormattedPrice() {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
    return formatter.format(_price);
  }

  String get material => _material;
  String get ukuran => _ukuran;
  String get kategori => _kategori;

  // Polymorphism: implementasi getInfo() method
  @override
  String getInfo() {
    return 'Harga: ${getFormattedPrice()} | Material: $_material | Ukuran: $_ukuran | Kategori: $_kategori';
  }

  // Override kategori produk
  @override
  String getCategory() => "Mainan Kucing";

  // Method khusus untuk mainan
  bool isSafeForKittens() => _kategori != 'Dewasa';

  // Static method untuk sample data
  static List<Mainan> get sampleData => [
    Mainan(
      id: 'T001',
      name: 'Bola Kucing Interaktif',
      description: 'Bola mainan dengan lonceng untuk kucing',
      imagePath: 'assets/mainan/bola.png',
      price: 25000,
      material: 'Plastik',
      ukuran: 'Kecil',
      kategori: 'Semua Umur',
      rating: 4.5,
    ),
    Mainan(
      id: 'T002',
      name: 'Tongkat Bulu',
      description: 'Tongkat dengan bulu untuk menarik perhatian kucing',
      imagePath: 'assets/mainan/bulu.png',
      price: 18000,
      material: 'Kayu & Bulu',
      ukuran: 'Sedang',
      kategori: 'Semua Umur',
      rating: 4.3,
    ),
    Mainan(
      id: 'T003',
      name: 'Laser Pointer',
      description: 'Pointer laser untuk bermain dengan kucing',
      imagePath: 'assets/mainan/laser.png',
      price: 35000,
      material: 'Logam',
      ukuran: 'Kecil',
      kategori: 'Dewasa',
      rating: 4.7,
    ),
    Mainan(
      id: 'T004',
      name: 'Garamari Kucing',
      description: 'Tempat tidur dan mainan dalam satu',
      imagePath: 'assets/mainan/garamari.png',
      price: 75000,
      material: 'Kain & Busa',
      ukuran: 'Besar',
      kategori: 'Semua Umur',
      rating: 4.8,
    ),
    Mainan(
      id: 'T005',
      name: 'Boneka Tikus',
      description: 'Boneka berbentuk tikus dengan catnip',
      imagePath: 'assets/mainan/tikus.png',
      price: 15000,
      material: 'Kain',
      ukuran: 'Kecil',
      kategori: 'Anak Kucing',
      rating: 4.4,
    ),
    Mainan(
      id: 'T006',
      name: 'Bola Lonceng',
      description: 'Bola kecil dengan lonceng di dalamnya.',
      imagePath: 'assets/mainan/lonceng.png',
      price: 12000,
      material: 'Plastik',
      ukuran: 'Kecil',
      kategori: 'Anak Kucing',
      rating: 4.5,
    ),

    Mainan(
      id: 'T007',
      name: 'Terowongan Lipat',
      description: 'Terowongan kain lipat untuk bermain petak umpet.',
      imagePath: 'assets/mainan/lipat.png',
      price: 55000,
      material: 'Kain Oxford',
      ukuran: 'Besar',
      kategori: 'Dewasa',
      rating: 4.8,
    ),
  ];
}
