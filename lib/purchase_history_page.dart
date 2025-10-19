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
        backgroundColor: const Color.fromARGB(255, 251, 112, 112),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: purchases.isEmpty
          ? const Center(
              child: Text(
                'Belum ada riwayat pembelian 📝',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: purchases.length,
              itemBuilder: (context, index) {
                final purchase = purchases[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    childrenPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pesanan #${purchase.id}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.redAccent.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Selesai',
                            style: TextStyle(
                              color: Colors.redAccent.shade200,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      'Tanggal: ${purchase.dateTime.toLocal().toString().split('.')[0]}',
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F8F8),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: purchase.items.length,
                          separatorBuilder: (_, __) =>
                              Divider(color: Colors.grey.shade300, height: 1),
                          itemBuilder: (context, i) {
                            final cartItem = purchase.items[i];
                            final produk = cartItem.produk;
                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: produk.imagePath.isNotEmpty
                                    ? Image.network(
                                        produk.imagePath,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) =>
                                            const Icon(Icons.broken_image),
                                      )
                                    : const Icon(Icons.image_not_supported),
                              ),
                              title: Text(
                                produk.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                              subtitle: Text(
                                '${produk.getFormattedPrice()} × ${cartItem.quantity}',
                                style: const TextStyle(fontSize: 13),
                              ),
                              trailing: Text(
                                'Rp ${cartItem.totalPrice.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.redAccent,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Pembayaran',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'Rp ${purchase.total.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
