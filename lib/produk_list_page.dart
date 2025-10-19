import 'package:flutter/material.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter_application_1/dashboard_page.dart';
import 'package:flutter_application_1/makanan_detail_page.dart';
import 'package:flutter_application_1/mainan_detail_page.dart';
import 'package:flutter_application_1/aksesoris_detail_page.dart';
import 'package:flutter_application_1/adopsi_detail_page.dart';
import 'package:flutter_application_1/cart_page.dart';
import 'package:flutter_application_1/purchase_history_page.dart';
import 'package:flutter_application_1/profile_page.dart';
import 'model/Produk.dart';
import 'model/makanan.dart';
import 'model/mainan.dart';
import 'model/aksesoris.dart';
import 'model/adopsi.dart';

class ProductRatingWidget extends StatelessWidget {
  final double rating;
  final double size;

  const ProductRatingWidget({super.key, required this.rating, this.size = 14});

  @override
  Widget build(BuildContext context) {
    return RatingBar.readOnly(
      filledIcon: Icons.star,
      emptyIcon: Icons.star_border,
      halfFilledIcon: Icons.star_half,
      isHalfAllowed: true,
      alignment: Alignment.center,
      size: size,
      maxRating: 5,
      initialRating: rating,
      filledColor: Colors.amber,
    );
  }
}

class ProdukListPage extends StatefulWidget {
  final String title;
  final List<Produk> produkList;

  const ProdukListPage({
    super.key,
    required this.title,
    required this.produkList,
  });

  @override
  State<ProdukListPage> createState() => _ProdukListPageState();
}

class _ProdukListPageState extends State<ProdukListPage> {
  String searchQuery = "";
  String sortOption = "Nama A-Z";

  @override
  Widget build(BuildContext context) {
    List<Produk> filteredList = widget.produkList
        .where((p) => p.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    switch (sortOption) {
      case "Nama A-Z":
        filteredList.sort((a, b) => a.name.compareTo(b.name));
        break;
      case "Nama Z-A":
        filteredList.sort((a, b) => b.name.compareTo(a.name));
        break;
      case "Rating Tinggi":
        filteredList.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case "Rating Rendah":
        filteredList.sort((a, b) => a.rating.compareTo(b.rating));
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color.fromARGB(255, 251, 112, 112),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = 6;
          if (constraints.maxWidth < 1800) crossAxisCount = 5;
          if (constraints.maxWidth < 1400) crossAxisCount = 4;
          if (constraints.maxWidth < 1100) crossAxisCount = 3;
          if (constraints.maxWidth < 800) crossAxisCount = 2;

          return Row(
            children: [
              /// === SIDEBAR KIRI ===
              Container(
                width: 200,
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
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfilePage(),
                            ),
                          );
                        },
                        child: Column(
                          children: const [
                            CircleAvatar(
                              radius: 45,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.person,
                                size: 50,
                                color: Color.fromARGB(255, 251, 112, 112),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Lihat Profil",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(color: Colors.white70, thickness: 1),
                    _buildSidebarTile(Icons.dashboard, "Dashboard", () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DashboardPage(),
                        ),
                      );
                    }),
                    _buildSidebarTile(Icons.fastfood, "Makanan", () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProdukListPage(
                            title: "Makanan",
                            produkList: Makanan.sampleData,
                          ),
                        ),
                      );
                    }),
                    _buildSidebarTile(Icons.toys, "Mainan", () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProdukListPage(
                            title: "Mainan",
                            produkList: Mainan.sampleData,
                          ),
                        ),
                      );
                    }),
                    _buildSidebarTile(Icons.shopping_bag, "Aksesoris", () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProdukListPage(
                            title: "Aksesoris",
                            produkList: Aksesoris.sampleData,
                          ),
                        ),
                      );
                    }),
                    _buildSidebarTile(Icons.pets, "Adopsi", () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProdukListPage(
                            title: "Adopsi",
                            produkList: Adopsi.sampleData,
                          ),
                        ),
                      );
                    }),
                    const Divider(color: Colors.white70, thickness: 1),
                    _buildSidebarTile(Icons.shopping_cart, "Keranjang", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartPage(),
                        ),
                      );
                    }),
                    _buildSidebarTile(
                      Icons.receipt_long,
                      "Riwayat Transaksi",
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PurchaseHistoryPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              /// === KONTEN UTAMA ===
              Expanded(
                child: Column(
                  children: [
                    _buildSearchAndSortBar(),
                    Expanded(
                      child: filteredList.isEmpty
                          ? const Center(
                              child: Text(
                                "Produk tidak ditemukan",
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          : GridView.builder(
                              padding: const EdgeInsets.all(16),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisCount,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 16,
                                    childAspectRatio: 0.9,
                                  ),
                              itemCount: filteredList.length,
                              itemBuilder: (context, index) {
                                final produk = filteredList[index];
                                return GestureDetector(
                                  onTap: () =>
                                      _navigateToDetail(context, produk),
                                  child: _buildProductCard(produk),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSidebarTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }

  Widget _buildSearchAndSortBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFFF0F5), Color(0xFFFFF9FB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 247, 202, 202),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 251, 112, 112),
                  ),
                  hintText: "Cari produk...",
                ),
                onChanged: (value) {
                  setState(() => searchQuery = value);
                },
              ),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.pink.shade200),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: sortOption,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Color.fromARGB(255, 251, 112, 112),
                ),
                items: const [
                  DropdownMenuItem(value: "Nama A-Z", child: Text("Nama A-Z")),
                  DropdownMenuItem(value: "Nama Z-A", child: Text("Nama Z-A")),
                  DropdownMenuItem(
                    value: "Rating Tinggi",
                    child: Text("Rating Tinggi"),
                  ),
                  DropdownMenuItem(
                    value: "Rating Rendah",
                    child: Text("Rating Rendah"),
                  ),
                ],
                onChanged: (value) {
                  setState(() => sortOption = value!);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Produk produk) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 247, 202, 202),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 235, 173, 173),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipOval(
              child: Image.asset(
                produk.imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              produk.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            ProductRatingWidget(rating: produk.rating, size: 14),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 251, 112, 112),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _getProdukPrice(produk),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getProdukPrice(Produk produk) {
    if (produk is Makanan) return produk.getFormattedPrice();
    if (produk is Mainan) return produk.getFormattedPrice();
    if (produk is Aksesoris) return produk.getFormattedPrice();
    if (produk is Adopsi) return "";
    return "";
  }

  void _navigateToDetail(BuildContext context, Produk produk) {
    if (produk is Makanan) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MakananDetailPage(makanan: produk),
        ),
      );
    } else if (produk is Mainan) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainanDetailPage(mainan: produk),
        ),
      );
    } else if (produk is Aksesoris) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AksesorisDetailPage(aksesoris: produk),
        ),
      );
    } else if (produk is Adopsi) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdopsiDetailPage(adopsi: produk),
        ),
      );
    }
  }
}
