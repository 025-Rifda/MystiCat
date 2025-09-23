import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/purchase_provider.dart';

class PurchaseHistoryPage extends StatelessWidget {
  const PurchaseHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final purchaseProvider = Provider.of<PurchaseProvider>(context);
    final purchases = purchaseProvider.purchases;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pembelian'),
        backgroundColor: Color.fromARGB(255, 251, 112, 112),
      ),
      body: purchases.isEmpty
          ? const Center(child: Text('Belum ada riwayat pembelian'))
          : ListView.builder(
              itemCount: purchases.length,
              itemBuilder: (context, index) {
                final purchase = purchases[index];
                return ExpansionTile(
                  title: Text(
                    'Pembelian #${purchase.id}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Tanggal: ${purchase.dateTime.toLocal().toString().split('.')[0]}',
                  ),
                  children: [
                    ...purchase.items.map((cartItem) {
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
                      );
                    }),
                    ListTile(
                      title: Text(
                        'Total: Rp ${purchase.total.toStringAsFixed(0)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
