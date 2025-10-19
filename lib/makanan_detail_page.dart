import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../cart_page.dart';
import '../chat_page.dart';
import '../model/makanan.dart';
import '../providers/cart_provider.dart';

class MakananDetailPage extends StatefulWidget {
  final Makanan makanan;

  const MakananDetailPage({super.key, required this.makanan});

  @override
  State<MakananDetailPage> createState() => _MakananDetailPageState();
}

class _MakananDetailPageState extends State<MakananDetailPage> {
  int _quantity = 1;
  double _userRating = 5.0;
  final TextEditingController _commentController = TextEditingController();

  final List<Map<String, dynamic>> _comments = [
    {"text": "Enak banget! 😋", "rating": 5.0, "date": DateTime.now()},
    {"text": "Lumayan, porsinya pas 👍", "rating": 4.0, "date": DateTime.now()},
  ];

  void _addComment() {
    final comment = _commentController.text.trim();
    if (comment.isNotEmpty && comment.length <= 200) {
      setState(() {
        _comments.add({
          "text": comment,
          "rating": _userRating,
          "date": DateTime.now(),
        });
        _commentController.clear();
        _userRating = 5.0;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Komentar & rating ditambahkan!")),
      );
    }
  }

  double get averageRating {
    if (_comments.isEmpty) return widget.makanan.rating;
    final sum = _comments.fold<double>(
      0.0,
      (prev, c) => prev + (c["rating"] as double),
    );
    return sum / _comments.length;
  }

  String formatPrice(double price) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: "Rp ");
    return formatter.format(price);
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.redAccent),
          const SizedBox(width: 8),
          Text(
            "$label: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 15))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F7),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 251, 112, 112),
        elevation: 4,
        title: Text(
          widget.makanan.name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartPage()),
                  );
                },
              ),
              if (cartProvider.itemCount > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: GFBadge(
                    color: Colors.white,
                    textColor: Colors.red,
                    shape: GFBadgeShape.circle,
                    size: GFSize.SMALL,
                    child: Text(cartProvider.itemCount.toString()),
                  ),
                ),
            ],
          ),
        ],
      ),

      // ==================== BODY ====================
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==================== KIRI: FOTO + ULASAN ====================
          Expanded(
            flex: 1,
            child: Column(
              children: [
                // ==== Gambar tetap di atas ====
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.network(
                        widget.makanan.imagePath,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                // ==== Scrollable komentar + form ====
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const Text(
                          "Ulasan Pembeli",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromARGB(255, 251, 112, 112),
                          ),
                        ),
                        const SizedBox(height: 12),

                        if (_comments.isEmpty)
                          const Text(
                            "Belum ada ulasan 🍰",
                            style: TextStyle(fontStyle: FontStyle.italic),
                          )
                        else
                          ..._comments.map(
                            (c) => Container(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 22,
                                    backgroundColor: Colors.pink.shade100,
                                    child: const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 26,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RatingBarIndicator(
                                          rating: c["rating"],
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                          itemCount: 5,
                                          itemSize: 18,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          c["text"],
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          DateFormat(
                                            'dd MMM yyyy, HH:mm',
                                          ).format(c["date"]),
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        const SizedBox(height: 24),

                        // ======= FORM ULASAN =======
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Tulis Ulasanmu",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 251, 112, 112),
                                ),
                              ),
                              const SizedBox(height: 8),
                              RatingBar(
                                initialRating: _userRating,
                                minRating: 1,
                                allowHalfRating: true,
                                itemCount: 5,
                                ratingWidget: RatingWidget(
                                  full: const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  half: const Icon(
                                    Icons.star_half,
                                    color: Colors.amber,
                                  ),
                                  empty: const Icon(
                                    Icons.star_border,
                                    color: Colors.amber,
                                  ),
                                ),
                                onRatingUpdate: (rating) {
                                  setState(() => _userRating = rating);
                                },
                              ),
                              const SizedBox(height: 12),
                              TextField(
                                controller: _commentController,
                                maxLines: 3,
                                decoration: InputDecoration(
                                  hintText:
                                      "Tulis komentar kamu (maks. 200 karakter)...",
                                  filled: true,
                                  fillColor: Colors.pink.shade50,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              GFButton(
                                onPressed: _addComment,
                                text: "Kirim Ulasan",
                                color: const Color.fromARGB(255, 251, 112, 112),
                                fullWidthButton: true,
                                icon: const Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ==================== KANAN: DETAIL PRODUK ====================
          Expanded(
            flex: 2,
            child: GFCard(
              elevation: 8,
              borderRadius: BorderRadius.circular(20),
              margin: const EdgeInsets.all(16),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.makanan.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 251, 112, 112),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    formatPrice(widget.makanan.price),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 10),
                  RatingBarIndicator(
                    rating: averageRating,
                    itemBuilder: (context, index) =>
                        const Icon(Icons.star, color: Colors.amber),
                    itemCount: 5,
                    itemSize: 24,
                    unratedColor: Colors.grey.shade300,
                  ),
                  Text("(${averageRating.toStringAsFixed(1)})"),
                  const Divider(height: 30),
                  const Text(
                    "Deskripsi Produk",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color.fromARGB(255, 251, 112, 112),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.makanan.description,
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 16),

                  _buildInfoRow("Jenis", widget.makanan.jenis, Icons.category),
                  _buildInfoRow(
                    "Brand",
                    widget.makanan.brand,
                    Icons.local_offer,
                  ),
                  _buildInfoRow(
                    "Stok",
                    widget.makanan.stok.toString(),
                    Icons.inventory,
                  ),

                  const Divider(height: 30),
                  Row(
                    children: [
                      GFIconButton(
                        onPressed: () {
                          setState(() {
                            if (_quantity > 1) _quantity--;
                          });
                        },
                        icon: const Icon(Icons.remove),
                        color: Colors.redAccent,
                        type: GFButtonType.solid,
                        size: GFSize.SMALL,
                        shape: GFIconButtonShape.circle,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          '$_quantity',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GFIconButton(
                        onPressed: () {
                          setState(() {
                            _quantity++;
                          });
                        },
                        icon: const Icon(Icons.add),
                        color: Colors.redAccent,
                        type: GFButtonType.solid,
                        size: GFSize.SMALL,
                        shape: GFIconButtonShape.circle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: GFButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ChatPage(),
                              ),
                            );
                          },
                          color: Colors.white,
                          textColor: Colors.red,
                          borderShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Colors.red),
                          ),
                          icon: const Icon(Icons.chat, color: Colors.red),
                          text: "Chat Penjual",
                          fullWidthButton: true,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GFButton(
                          onPressed: () {
                            cartProvider.addItem(
                              widget.makanan,
                              quantity: _quantity,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  251,
                                  112,
                                  112,
                                ),
                                content: Text(
                                  '${widget.makanan.name} x$_quantity ditambahkan ke keranjang 🛒',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          color: const Color.fromARGB(255, 251, 112, 112),
                          text: "Tambah ke Keranjang",
                          icon: const Icon(
                            Icons.add_shopping_cart,
                            color: Colors.white,
                          ),
                          fullWidthButton: true,
                        ),
                      ),
                    ],
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
