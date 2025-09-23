import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/adopsi.dart';
import 'providers/cart_provider.dart';

class AdopsiDetailPage extends StatelessWidget {
  final Adopsi adopsi;

  const AdopsiDetailPage({super.key, required this.adopsi});

  // Reusable info row (sama persis desainnya dengan Makanan)
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
                gradient: const LinearGradient(
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
          adopsi.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 251, 112, 112),
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
                      color: const Color.fromARGB(255, 251, 112, 112),
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(
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
                  child: adopsi.imagePath.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            adopsi.imagePath,
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
                          Icons.favorite,
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
                        adopsi.name,
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
                        adopsi.description,
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
                      _buildInfoRow("Ras", adopsi.ras, icon: Icons.pets),
                      _buildInfoRow("Umur", adopsi.umur, icon: Icons.cake),
                      _buildInfoRow(
                        "Jenis Kelamin",
                        adopsi.jenisKelamin,
                        icon: adopsi.jenisKelamin.toLowerCase() == "jantan"
                            ? Icons.male
                            : Icons.female,
                      ),
                      _buildInfoRow(
                        "Lokasi",
                        adopsi.lokasi,
                        icon: Icons.location_on,
                      ),
                      _buildInfoRow(
                        "Vaksin",
                        adopsi.vaksinLengkap ? "Lengkap" : "Belum",
                        icon: Icons.vaccines,
                      ),
                      _buildInfoRow(
                        "Steril",
                        adopsi.steril ? "Ya" : "Tidak",
                        icon: Icons.healing,
                      ),
                      _buildInfoRow(
                        "Kepribadian",
                        adopsi.getPersonalityString(),
                        icon: Icons.mood,
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
                          _buildRatingStars(adopsi.rating),
                        ],
                      ),

                      const SizedBox(height: 18),

                      // Status adopsi
                      Center(
                        child: Chip(
                          label: Text(
                            adopsi.getAdoptionStatus(),
                            style: const TextStyle(
                              color: Color.fromARGB(255, 251, 112, 112),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          backgroundColor: adopsi.isReadyForAdoption()
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
                            backgroundColor: const Color.fromARGB(
                              255,
                              251,
                              112,
                              112,
                            ),
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
                            ).addItem(adopsi);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  251,
                                  112,
                                  112,
                                ),
                                content: Text(
                                  '${adopsi.name} ditambahkan ke keranjang 🛒',
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
