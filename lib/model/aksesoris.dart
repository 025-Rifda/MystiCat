import 'package:intl/intl.dart';
import 'package:flutter_application_1/model/Produk.dart';

// Aksesoris class menggunakan konsep Inheritance dari Produk
class Aksesoris extends Produk {
  // Encapsulation: private fields
  final double _price;
  final String _tipe;
  final String _bahan;
  final String _warna;
  final bool _waterproof;

  // Constructor
  Aksesoris({
    required super.id,
    required super.name,
    required super.description,
    required super.imagePath,
    required double price,
    required String tipe,
    required String bahan,
    String warna = 'Natural',
    bool waterproof = false,
    super.rating = 0.0,
  }) : _price = price,
       _tipe = tipe,
       _bahan = bahan,
       _warna = warna,
       _waterproof = waterproof;

  // Getter methods (Encapsulation)
  @override
  double get price => _price;

  @override
  String getFormattedPrice() {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
    return formatter.format(_price);
  }

  String get tipe => _tipe;
  String get bahan => _bahan;
  String get warna => _warna;
  bool get waterproof => _waterproof;

  // Polymorphism: implementasi getInfo() method
  @override
  String getInfo() {
    return 'Harga: ${getFormattedPrice()} | Tipe: $_tipe | Bahan: $_bahan | Warna: $_warna | Waterproof: ${_waterproof ? "Ya" : "Tidak"}';
  }

  // Override kategori produk
  @override
  String getCategory() => "Aksesoris Kucing";

  // Method khusus untuk aksesoris
  bool isSuitableForOutdoor() => _waterproof;

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'tipe': _tipe,
      'bahan': _bahan,
      'warna': _warna,
      'waterproof': _waterproof,
    };
  }

  factory Aksesoris.fromMap(Map<String, dynamic> map) {
    return Aksesoris(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      imagePath: map['imagePath'],
      price: map['price'],
      tipe: map['tipe'],
      bahan: map['bahan'],
      warna: map['warna'],
      waterproof: map['waterproof'],
      rating: map['rating'],
    );
  }

  // Static method untuk sample data
  static List<Aksesoris> get sampleData => [
    Aksesoris(
      id: 'A001',
      name: 'Tempat Makan Stainless',
      description: 'Mangkok makan dari stainless steel anti karat',
      imagePath: 'assets/aksesoris/makan.png',
      price: 35000,
      tipe: 'Tempat Makan',
      bahan: 'Stainless Steel',
      warna: 'Silver',
      waterproof: true,
      rating: 4.7,
    ),
    Aksesoris(
      id: 'A002',
      name: 'Carrier Kucing Portable',
      description: 'Tas carrier untuk membawa kucing bepergian',
      imagePath: 'assets/aksesoris/carrier.png',
      price: 125000,
      tipe: 'Carrier',
      bahan: 'Kain Oxford',
      warna: 'Hitam',
      waterproof: false,
      rating: 4.8,
    ),
    Aksesoris(
      id: 'A003',
      name: 'Sisir Bulu Kucing',
      description: 'Sisir khusus untuk merawat bulu kucing',
      imagePath: 'assets/aksesoris/sisir.png',
      price: 28000,
      tipe: 'Grooming',
      bahan: 'Plastik & Logam',
      warna: 'Pink',
      waterproof: false,
      rating: 4.4,
    ),

    Aksesoris(
      id: 'A004',
      name: 'Kalung Kucing Lonceng',
      description:
          'Kalung lucu dengan lonceng kecil agar kucing mudah ditemukan.',
      imagePath: 'assets/aksesoris/kalung.png',
      price: 15000,
      tipe: 'Kalung',
      bahan: 'Kain & Lonceng',
      warna: 'Merah',
      waterproof: false,
      rating: 4.5,
    ),

    Aksesoris(
      id: 'A005',
      name: 'Tempat Tidur Busa',
      description: 'Tempat tidur empuk agar kucing nyaman beristirahat.',
      imagePath: 'assets/aksesoris/kasur.png',
      price: 75000,
      tipe: 'Tempat Tidur',
      bahan: 'Busa & Kain',
      warna: 'Biru',
      waterproof: true,
      rating: 4.7,
    ),

    Aksesoris(
      id: 'A006',
      name: 'Mangkok Makan Ganda',
      description: 'Mangkok makan dua sisi untuk makanan dan minuman.',
      imagePath: 'assets/aksesoris/ganda.png',
      price: 48000,
      tipe: 'Perlengkapan Makan',
      bahan: 'Plastik',
      warna: 'Hijau',
      waterproof: true,
      rating: 4.6,
    ),
  ];
}
