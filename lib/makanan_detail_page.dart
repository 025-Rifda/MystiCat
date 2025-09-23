import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/makanan.dart';
import 'providers/cart_provider.dart';

class MakananDetailPage extends StatelessWidget {
  final Makanan makanan;

  const MakananDetailPage({super.key, required this.makanan});

  // Reusable info row
  Widget _buildInfoRow(String label, String value, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null)
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 247, 202, 202),
                    Color.fromARGB(255, 251, 112, 112),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(6),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
          if (icon != null) const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black87, fontSize: 15),
                children: [
                  TextSpan(
                    text: "$label: ",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 251, 112, 112),
                    ),
                  ),
                  TextSpan(text: value),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Rating bintang
  Widget _buildRatingStars(double rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating.round() ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 20,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F7),
      appBar: AppBar(
        title: Text(
          makanan.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 251, 112, 112),
        elevation: 6,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            // ================= KIRI: GAMBAR =================
            Expanded(
              flex: 1,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Color.fromARGB(255, 251, 112, 112),
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(
                          255,
                          251,
                          112,
                          112,
                        ).withOpacity(0.25),
                        blurRadius: 15,
                        offset: const Offset(4, 6),
                      ),
                    ],
                  ),
                  child: makanan.imagePath.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            makanan.imagePath,
                            fit: BoxFit.cover,
                            height: 260,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.broken_image,
                                size: 100,
                                color: Colors.grey,
                              );
                            },
                          ),
                        )
                      : const Icon(
                          Icons.fastfood,
                          size: 120,
                          color: Color.fromARGB(255, 251, 112, 112),
                        ),
                ),
              ),
            ),

            const SizedBox(width: 25),

            // ================= KANAN: DETAIL =================
            Expanded(
              flex: 2,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 6,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nama
                      Text(
                        makanan.name,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 251, 112, 112),
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Deskripsi
                      Text(
                        makanan.description,
                        style: TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey.shade600,
                          height: 1.4,
                        ),
                      ),
                      const Divider(
                        height: 30,
                        thickness: 1.2,
                        color: Color.fromARGB(255, 247, 202, 202),
                      ),

                      // Info rows
                      _buildInfoRow(
                        "Harga",
                        makanan.getFormattedPrice(),
                        icon: Icons.price_change,
                      ),
                      _buildInfoRow(
                        "Jenis",
                        makanan.jenis,
                        icon: Icons.category,
                      ),
                      _buildInfoRow(
                        "Brand",
                        makanan.brand,
                        icon: Icons.local_offer,
                      ),
                      _buildInfoRow(
                        "Stok",
                        makanan.stok.toString(),
                        icon: Icons.inventory,
                      ),

                      const SizedBox(height: 10),

                      // Rating
                      Row(
                        children: [
                          const Text(
                            "Rating: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 251, 112, 112),
                            ),
                          ),
                          _buildRatingStars(makanan.rating),
                        ],
                      ),

                      const SizedBox(height: 18),

                      // Status stok
                      Center(
                        child: Chip(
                          label: Text(
                            makanan.isAvailable() ? "Tersedia" : "Stok Habis",
                            style: const TextStyle(
                              color: Color.fromARGB(255, 251, 112, 112),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          backgroundColor: makanan.isAvailable()
                              ? Colors.white
                              : const Color.fromARGB(255, 255, 255, 255),
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                        ),
                      ),

                      const Spacer(),

                      // Tombol tambah ke keranjang
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 251, 112, 112),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            elevation: 5,
                          ),
                          onPressed: () {
                            Provider.of<CartProvider>(
                              context,
                              listen: false,
                            ).addItem(makanan);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Color.fromARGB(
                                  255,
                                  251,
                                  112,
                                  112,
                                ),
                                content: Text(
                                  '${makanan.name} ditambahkan ke keranjang 🛒',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          child: const Text(
                            "Tambah ke Keranjang",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
