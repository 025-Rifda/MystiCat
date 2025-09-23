import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'providers/purchase_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final purchaseProvider = Provider.of<PurchaseProvider>(
      context,
      listen: false,
    );

    final items = cartProvider.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
        backgroundColor: Color.fromARGB(255, 251, 112, 112),
      ),
      body: items.isEmpty
          ? const Center(child: Text('Keranjang kosong'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final cartItem = items[index];
                      final produk = cartItem.produk;

                      return ListTile(
                        leading: produk.imagePath.isNotEmpty
                            ? Image.network(
                                produk.imagePath,
                                width: 50,
                                height: 50,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.broken_image),
                              )
                            : const Icon(Icons.image_not_supported),
                        title: Text(produk.name),
                        subtitle: Text(
                          '${produk.getFormattedPrice()} x ${cartItem.quantity}\n'
                          'Subtotal: Rp ${cartItem.totalPrice.toStringAsFixed(0)}',
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            cartProvider.removeItem(produk);
                          },
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Total: Rp ${cartProvider.totalPrice.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 251, 112, 112),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          if (items.isEmpty) return;

                          // Simpan ke riwayat pembelian
                          purchaseProvider.addPurchase(
                            items.map((e) => e).toList(),
                          );

                          // Simpan data untuk struk
                          final purchasedItems = List.from(items);
                          final total = cartProvider.totalPrice;

                          // Kosongkan keranjang
                          cartProvider.clear();

                          // Tampilkan struk
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Struk Pembelian'),
                                content: SizedBox(
                                  width: double.maxFinite,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ...purchasedItems.map(
                                        (e) => Text(
                                          "${e.produk.name} x${e.quantity} = Rp ${e.totalPrice.toStringAsFixed(0)}",
                                        ),
                                      ),
                                      const Divider(),
                                      Text(
                                        "Total: Rp ${total.toStringAsFixed(0)}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Tutup'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text(
                          'Beli Sekarang',
                          style: TextStyle(fontSize: 18),
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
