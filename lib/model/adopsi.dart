import 'package:flutter_application_1/model/Produk.dart';

// Adopsi class menggunakan konsep Inheritance dari Produk

// Adopsi class menggunakan konsep Inheritance dari Produk
class Adopsi extends Produk {
  // Encapsulation: private fields
  final String _ras;
  final String _umur;
  final String _jenisKelamin;
  final String _lokasi;
  final bool _vaksinLengkap;
  final bool _steril;
  final List<String> _kepribadian;
  final double _price;

  // Constructor
  Adopsi({
    required String id,
    required String name,
    required String description,
    required String imagePath,
    required String ras,
    required String umur,
    required String jenisKelamin,
    required String lokasi,
    bool vaksinLengkap = false,
    bool steril = false,
    List<String> kepribadian = const [],
    required double price,
    super.rating = 0.0,
  }) : _ras = ras,
       _umur = umur,
       _jenisKelamin = jenisKelamin,
       _lokasi = lokasi,
       _vaksinLengkap = vaksinLengkap,
       _steril = steril,
       _kepribadian = kepribadian,
       _price = price,
       super(
         id: id,
         name: name,
         description: description,
         imagePath: imagePath,
       );

  // Getter methods (Encapsulation)
  String get ras => _ras;
  String get umur => _umur;
  String get jenisKelamin => _jenisKelamin;
  String get lokasi => _lokasi;
  bool get vaksinLengkap => _vaksinLengkap;
  bool get steril => _steril;
  List<String> get kepribadian => _kepribadian;

  @override
  double get price => _price;

  @override
  String getFormattedPrice() {
    return 'Gratis';
  }

  // Polymorphism: implementasi getInfo() method
  @override
  String getInfo() {
    return 'Ras: $_ras | Umur: $_umur | Kelamin: $_jenisKelamin | Lokasi: $_lokasi | '
        'Vaksin: ${_vaksinLengkap ? "Lengkap" : "Belum"} | Steril: ${_steril ? "Ya" : "Tidak"} | '
        'Kepribadian: ${getPersonalityString()}';
  }

  // Override kategori produk
  @override
  String getCategory() => "Adopsi Kucing";

  // Method khusus untuk adopsi
  bool isReadyForAdoption() => _vaksinLengkap && _steril;

  String getPersonalityString() {
    return _kepribadian.isNotEmpty
        ? _kepribadian.join(', ')
        : 'Belum diketahui';
  }

  String getAdoptionStatus() {
    return isReadyForAdoption() ? "Siap Adopsi" : "Belum Siap";
  }

  // Static method untuk sample data
  static List<Adopsi> get sampleData => [
    Adopsi(
      id: 'AD001',
      name: 'Milo',
      description: 'Kucing lucu dan aktif, cocok untuk keluarga',
      imagePath: 'assets/adopsi/milo.png',
      ras: 'Kampung',
      umur: '2 tahun',
      jenisKelamin: 'Jantan',
      lokasi: 'Jakarta Selatan',
      vaksinLengkap: true,
      steril: true,
      kepribadian: ['Aktif', 'Penyayang', 'Cerdas'],
      price: 0,
      rating: 5.0,
    ),
    Adopsi(
      id: 'AD002',
      name: 'Luna',
      description: 'Kucing betina yang manja dan suka diemong',
      imagePath: 'assets/adopsi/luna.png',
      ras: 'Persia',
      umur: '1 tahun',
      jenisKelamin: 'Betina',
      lokasi: 'Jakarta Pusat',
      vaksinLengkap: true,
      steril: false,
      kepribadian: ['Manja', 'Pemalu', 'Setia'],
      price: 0,
      rating: 4.9,
    ),
    Adopsi(
      id: 'AD003',
      name: 'Tiger',
      description: 'Kucing jantan dengan corak harimau, sangat lincah',
      imagePath: 'assets/adopsi/tiger.png',
      ras: 'Kampung',
      umur: '6 bulan',
      jenisKelamin: 'Jantan',
      lokasi: 'Jakarta Barat',
      vaksinLengkap: false,
      steril: false,
      kepribadian: ['Lincah', 'Petualang', 'Mandiri'],
      price: 0,
      rating: 4.7,
    ),
    Adopsi(
      id: 'AD004',
      name: 'Snow',
      description: 'Kucing putih cantik dengan mata biru',
      imagePath: 'assets/adopsi/snow.png',
      ras: 'Angora',
      umur: '3 tahun',
      jenisKelamin: 'Betina',
      lokasi: 'Jakarta Timur',
      vaksinLengkap: true,
      steril: true,
      kepribadian: ['Tenang', 'Elegan', 'Pemilih'],
      price: 0,
      rating: 4.8,
    ),
  ];
}
