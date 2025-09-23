import 'package:flutter/material.dart';
import 'package:flutter_application_1/makanan_detail_page.dart';
import 'package:flutter_application_1/mainan_detail_page.dart';
import 'package:flutter_application_1/aksesoris_detail_page.dart';
import 'package:flutter_application_1/adopsi_detail_page.dart';
import 'package:flutter_application_1/cart_page.dart';
import 'package:flutter_application_1/purchase_history_page.dart';
import 'model/Produk.dart';
import 'model/makanan.dart';
import 'model/mainan.dart';
import 'model/aksesoris.dart';
import 'model/adopsi.dart';

// ================= PRODUK LIST PAGE ==================
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

  // ✅ Map kategori ke sampleData
  final kategoriProduk = {
    "Makanan": Makanan.sampleData,
    "Mainan": Mainan.sampleData,
    "Aksesoris": Aksesoris.sampleData,
    "Adopsi": Adopsi.sampleData,
  };

  @override
  Widget build(BuildContext context) {
    // Filter
    List<Produk> filteredList = widget.produkList
        .where((p) => p.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    // Sorting
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
      body: Row(
        children: [
          // ================= SIDEBAR =================
          Container(
            width: 200,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 247, 202, 202),
                  Color.fromARGB(255, 251, 112, 112),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(2, 0),
                ),
              ],
            ),
            child: ListView(
              children: [
                const DrawerHeader(
                  child: Center(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Color.fromARGB(255, 251, 112, 112),
                      ),
                    ),
                  ),
                ),

                // ✅ Home
                ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Color.fromARGB(255, 251, 112, 112),
                  ),
                  title: const Text("Home"),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProdukListPage(
                          title: "Makanan",
                          produkList: Makanan.sampleData,
                        ),
                      ),
                    );
                  },
                ),

                // ✅ Loop kategori
                ...kategoriProduk.keys.map((kategori) {
                  IconData icon;
                  switch (kategori) {
                    case "Makanan":
                      icon = Icons.fastfood;
                      break;
                    case "Mainan":
                      icon = Icons.toys;
                      break;
                    case "Aksesoris":
                      icon = Icons.shopping_bag;
                      break;
                    case "Adopsi":
                      icon = Icons.pets;
                      break;
                    default:
                      icon = Icons.category;
                  }

                  return ListTile(
                    leading: Icon(
                      icon,
                      color: const Color.fromARGB(255, 251, 112, 112),
                    ),
                    title: Text(kategori),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProdukListPage(
                            title: kategori,
                            produkList: kategoriProduk[kategori]!,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),

                // ✅ Keranjang
                ListTile(
                  leading: const Icon(
                    Icons.shopping_cart,
                    color: Color.fromARGB(255, 251, 112, 112),
                  ),
                  title: const Text("Keranjang"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CartPage()),
                    );
                  },
                ),

                // ✅ Riwayat Transaksi
                ListTile(
                  leading: const Icon(
                    Icons.receipt_long,
                    color: Color.fromARGB(255, 251, 112, 112),
                  ),
                  title: const Text("Riwayat Transaksi"),
                  onTap: () {
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

          // ================= MAIN CONTENT =================
          Expanded(
            child: Column(
              children: [
                // Search + Sort
                Container(
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
                      // Search
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.pink.shade100.withOpacity(0.4),
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
                      // Sort Dropdown
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
                              DropdownMenuItem(
                                value: "Nama A-Z",
                                child: Text("Nama A-Z"),
                              ),
                              DropdownMenuItem(
                                value: "Nama Z-A",
                                child: Text("Nama Z-A"),
                              ),
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
                ),

                // Produk Grid
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
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    6, // ✅ ganti 6 biar muat di layar
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: 0.75,
                              ),
                          itemCount: filteredList.length,
                          itemBuilder: (context, index) {
                            final produk = filteredList[index];
                            return GestureDetector(
                              onTap: () {
                                if (produk is Makanan) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          MakananDetailPage(makanan: produk),
                                    ),
                                  );
                                } else if (produk is Mainan) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          MainanDetailPage(mainan: produk),
                                    ),
                                  );
                                } else if (produk is Aksesoris) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AksesorisDetailPage(
                                        aksesoris: produk,
                                      ),
                                    ),
                                  );
                                } else if (produk is Adopsi) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AdopsiDetailPage(adopsi: produk),
                                    ),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProdukDetailPage(produk: produk),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 255, 235, 235),
                                      Color.fromARGB(255, 247, 202, 202),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.pink.shade100.withOpacity(
                                        0.3,
                                      ),
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 8),
                                    ClipOval(
                                      child: Image.asset(
                                        produk.imagePath,
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      produk.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          size: 14,
                                          color: Colors.amber,
                                        ),
                                        const SizedBox(width: 2),
                                        Text(
                                          produk.rating.toString(),
                                          style: const TextStyle(fontSize: 11),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        margin: const EdgeInsets.all(8),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                            255,
                                            224,
                                            78,
                                            78,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Text(
                                          produk is Makanan
                                              ? produk.getFormattedPrice()
                                              : produk is Mainan
                                              ? produk.getFormattedPrice()
                                              : produk is Aksesoris
                                              ? produk.getFormattedPrice()
                                              : produk is Adopsi
                                              ? "" // Adopsi gratis
                                              : "",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
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
          ),
        ],
      ),
    );
  }
}

// ================= DETAIL PRODUK DEFAULT =================
class ProdukDetailPage extends StatelessWidget {
  final Produk produk;

  const ProdukDetailPage({super.key, required this.produk});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(produk.name),
        backgroundColor: const Color.fromARGB(255, 251, 112, 112),
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset(produk.imagePath, width: 200),
            const SizedBox(height: 20),
            Text("Detail untuk ${produk.name}"),
          ],
        ),
      ),
    );
  }
}
