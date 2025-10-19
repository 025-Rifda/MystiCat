import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';

import 'model/makanan.dart';
import 'model/mainan.dart';
import 'model/aksesoris.dart';
import 'model/adopsi.dart';
import 'model/Produk.dart';
import 'produk_list_page.dart';
import 'profile_page.dart';
import 'cart_page.dart';
import 'purchase_history_page.dart';
import 'login_page.dart';
import 'providers/user_provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

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

  final List<String> catTips = [
    "Beri makan kucing 2–3 kali sehari dengan porsi seimbang 🍽️",
    "Sediakan air bersih setiap hari 💧",
    "Jangan lupa vaksinasi rutin untuk menjaga kesehatannya 💉",
    "Sisir bulunya minimal 2 kali seminggu untuk mencegah rontok 🪮",
    "Luangkan waktu bermain agar kucing tidak stres 🧶",
    "Gunakan pasir yang bersih dan rutin diganti 🏖️",
    "Berikan tempat tidur yang nyaman untuknya 🛏️",
    "Jangan berikan makanan anjing untuk kucing 🚫",
  ];

  final List<String> catFacts = [
    "Kucing bisa tidur hingga 16 jam sehari 😴",
    "Kucing memiliki lebih dari 100 suara berbeda 🐈",
    "Dengkuran kucing dapat menenangkan manusia 💗",
    "Kucing selalu mendarat dengan empat kaki karena refleks keseimbangan uniknya 🐾",
    "Kucing tidak bisa merasakan rasa manis 🍬",
  ];

  late final String randomQuote;
  late final List<String> randomTips;
  late final List<String> randomFacts;

  @override
  void initState() {
    super.initState();
    final rand = Random();
    randomQuote = catQuotes[rand.nextInt(catQuotes.length)];
    randomTips = List.generate(5, (_) => catTips[rand.nextInt(catTips.length)]);
    randomFacts = List.generate(
      3,
      (_) => catFacts[rand.nextInt(catFacts.length)],
    );
  }

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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ProdukListPage(title: category, produkList: getProduk(category)),
      ),
    );
  }

  void _navigateToPage(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  Widget _buildInfoContainer({required String title, required Widget content}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFF5F8), Color.fromARGB(255, 255, 165, 165)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(2, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 251, 112, 112),
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 8),
          content,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF7FA),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  icon: const Icon(Icons.person, color: Colors.white),
                  onPressed: () => _navigateToPage(const ProfilePage()),
                ),
                const SizedBox(height: 20),
                IconButton(
                  icon: const Icon(Icons.home, color: Colors.white),
                  onPressed: () {},
                ),
                const SizedBox(height: 20),
                IconButton(
                  icon: const Icon(Icons.fastfood, color: Colors.white),
                  onPressed: () => _navigateToCategory("Makanan"),
                ),
                const SizedBox(height: 20),
                IconButton(
                  icon: const Icon(Icons.toys, color: Colors.white),
                  onPressed: () => _navigateToCategory("Mainan"),
                ),
                const SizedBox(height: 20),
                IconButton(
                  icon: const Icon(Icons.pets, color: Colors.white),
                  onPressed: () => _navigateToCategory("Aksesoris"),
                ),
                const SizedBox(height: 20),
                IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.white),
                  onPressed: () => _navigateToCategory("Adopsi"),
                ),
                const SizedBox(height: 20),
                IconButton(
                  icon: const Icon(Icons.shopping_cart, color: Colors.white),
                  onPressed: () => _navigateToPage(const CartPage()),
                ),
                const SizedBox(height: 20),
                IconButton(
                  icon: const Icon(Icons.history, color: Colors.white),
                  onPressed: () => _navigateToPage(const PurchaseHistoryPage()),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.logout, color: Colors.white),
                  onPressed: _logout,
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
                              Consumer<UserProvider>(
                                builder: (context, userProvider, child) {
                                  return Text(
                                    "Hai, ${userProvider.username} 👋",
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  );
                                },
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
                        const Color.fromARGB(255, 247, 202, 202),
                        const Color.fromARGB(255, 251, 112, 112),
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
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  margin: const EdgeInsets.all(13),
                  padding: const EdgeInsets.all(0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildInfoContainer(
                          title: "Quotes 🐱",
                          content: Text(
                            randomQuote,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        const SizedBox(height: 18),

                        _buildInfoContainer(
                          title: "Tips Merawat Kucing 💗",
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: randomTips.map((tip) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 6),
                                child: Text(
                                  "• $tip",
                                  style: const TextStyle(fontSize: 14),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 18),

                        _buildInfoContainer(
                          title: "Fun Fact Kucing 🐾",
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: randomFacts.map((fact) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 6),
                                child: Text(
                                  "• $fact",
                                  style: const TextStyle(fontSize: 14),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 18),

                        _buildInfoContainer(
                          title: "Reminder Harian ⏰",
                          content: const Text(
                            "Jangan lupa bermain sebentar dengan anabulmu hari ini 💕",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
