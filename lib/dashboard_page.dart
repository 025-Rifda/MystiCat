import 'package:flutter/material.dart';
import 'dart:math';
import 'model/makanan.dart';
import 'model/mainan.dart';
import 'model/aksesoris.dart';
import 'model/adopsi.dart';
import 'model/Produk.dart';
import 'produk_list_page.dart';

class DashboardPage extends StatefulWidget {
  final String username;
  const DashboardPage({super.key, required this.username});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<Map<String, dynamic>> categories = const [
    {"title": "Makanan", "image": "assets/makanan.png"},
    {"title": "Mainan", "image": "assets/mainan.png"},
    {"title": "Aksesoris", "image": "assets/aksesoris.png"},
    {"title": "Adopsi", "image": "assets/adopsi.png"},
  ];

  final List<String> catQuotes = [
    "Kucing bukan hanya hewan peliharaan, dia adalah keluarga 🐱",
    "Dalam setiap dengkuran ada ketenangan hati 💕",
    "Kucing mengajarkan kita tentang kesabaran dan kasih sayang 🐾",
    "Adopsi satu kucing, selamatkan dua nyawa: dia dan hatimu ❤️",
  ];

  List<Produk> getProduk(String category) {
    switch (category) {
      case "Makanan":
        return Makanan.sampleData;
      case "Mainan":
        return Mainan.sampleData;
      case "Aksesoris":
        return Aksesoris.sampleData;
      case "Adopsi":
        return Adopsi.sampleData;
      default:
        return [];
    }
  }

  void _navigateToCategory(String category) {
    final produkList = getProduk(category);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ProdukListPage(title: category, produkList: produkList),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final randomQuote = catQuotes[Random().nextInt(catQuotes.length)];

    return Scaffold(
      backgroundColor: const Color(0xFFFDF7FA),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // === SIDEBAR KIRI ===
          Container(
            width: 70,
            padding: const EdgeInsets.symmetric(vertical: 30),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 251, 112, 112),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(2, 0),
                ),
              ],
            ),
            child: Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.home, color: Colors.white),
                  onPressed: () {},
                ),
                const SizedBox(height: 30),
                IconButton(
                  icon: const Icon(Icons.fastfood, color: Colors.white),
                  onPressed: () => _navigateToCategory("Makanan"),
                ),
                const SizedBox(height: 30),
                IconButton(
                  icon: const Icon(Icons.toys, color: Colors.white),
                  onPressed: () => _navigateToCategory("Mainan"),
                ),
                const SizedBox(height: 30),
                IconButton(
                  icon: const Icon(Icons.pets, color: Colors.white),
                  onPressed: () => _navigateToCategory("Aksesoris"),
                ),
                const SizedBox(height: 30),
                IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.white),
                  onPressed: () => _navigateToCategory("Adopsi"),
                ),
              ],
            ),
          ),

          // === BAGIAN TENGAH ===
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Banner
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 247, 202, 202),
                          Color.fromARGB(255, 251, 112, 112),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Image.asset("assets/icon/icon.png", height: 80),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Hai, ${widget.username} 👋",
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                "Selamat datang di MYSTICAT, toko kucing favorit anabul",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Section Kategori
                  const Text(
                    "Kategori",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(height: 16),

                  Column(
                    children: categories.asMap().entries.map((entry) {
                      int index = entry.key;
                      var category = entry.value;

                      final List<Color> colors = [
                        Color.fromARGB(255, 247, 202, 202),
                        Color.fromARGB(255, 251, 112, 112),
                        Color.fromARGB(255, 247, 202, 202),
                        Color.fromARGB(255, 251, 112, 112),
                      ];

                      return GestureDetector(
                        onTap: () => _navigateToCategory(category["title"]),
                        child: TweenAnimationBuilder(
                          duration: Duration(milliseconds: 600 + (index * 200)),
                          curve: Curves.easeOut,
                          tween: Tween<double>(begin: 0, end: 1),
                          builder: (context, double value, child) {
                            return Opacity(
                              opacity: value,
                              child: Transform.translate(
                                offset: Offset(0, (1 - value) * 40),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: colors[index % colors.length],
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: colors[index % colors.length]
                                            .withOpacity(0.4),
                                        blurRadius: 10,
                                        offset: const Offset(2, 6),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 28,
                                        backgroundColor: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Image.asset(
                                            category["image"],
                                            fit: BoxFit.contain,
                                            height: 40,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Text(
                                          category["title"],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const Icon(
                                        Icons.chevron_right,
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),

          // === SIDEBAR KANAN ===
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 247, 202, 202),
                    Color.fromARGB(255, 251, 112, 112),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Quotes Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pink.shade100.withOpacity(0.4),
                          blurRadius: 10,
                          offset: const Offset(2, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.format_quote,
                          size: 36,
                          color: Color.fromARGB(255, 251, 112, 112),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          randomQuote,
                          style: const TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Favorit Card
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.pink.shade100.withOpacity(0.4),
                            blurRadius: 10,
                            offset: const Offset(2, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Favorit",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 251, 112, 112),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Expanded(
                            child: ListView(
                              children: const [
                                ListTile(
                                  dense: true,
                                  leading: Icon(
                                    Icons.fastfood,
                                    color: Colors.grey,
                                  ),
                                  title: Text("Whiskas Tuna"),
                                  trailing: Text("⭐ 4.8"),
                                ),
                                ListTile(
                                  dense: true,
                                  leading: Icon(Icons.toys, color: Colors.grey),
                                  title: Text("Bola Kucing"),
                                  trailing: Text("⭐ 4.5"),
                                ),
                                ListTile(
                                  dense: true,
                                  leading: Icon(
                                    Icons.favorite,
                                    color: Colors.grey,
                                  ),
                                  title: Text("Adopsi Kitty"),
                                  trailing: Text("⭐ 5.0"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Tips Perawatan Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pink.shade100.withOpacity(0.4),
                          blurRadius: 10,
                          offset: const Offset(2, 4),
                        ),
                      ],
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tips Perawatan 🐾",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 251, 112, 112),
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          "✔ Sisir bulu kucing secara rutin untuk mengurangi rontok dan mencegah bulu kusut.\n\n"
                          "✔ Berikan makanan bergizi seimbang agar kucing tetap sehat dan energik.\n\n"
                          "✔ Lakukan pemeriksaan kesehatan ke dokter hewan minimal 6 bulan sekali.\n\n",
                          style: TextStyle(fontSize: 12, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
