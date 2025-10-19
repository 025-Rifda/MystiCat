import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'providers/purchase_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with SingleTickerProviderStateMixin {
  bool _showSuccess = false;
  late AnimationController _checkController;

  @override
  void initState() {
    super.initState();
    _checkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
  }

  @override
  void dispose() {
    _checkController.dispose();
    super.dispose();
  }

  void _triggerSuccessAnimation() async {
    setState(() {
      _showSuccess = true;
    });
    _checkController.forward(from: 0);
    await Future.delayed(const Duration(seconds: 1, milliseconds: 300));
    setState(() {
      _showSuccess = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final purchase = context.read<PurchaseProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
        backgroundColor: const Color.fromARGB(255, 251, 112, 112),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: cart.items.isEmpty
          ? const Center(
              child: Text(
                'Keranjang kosong 😿',
                style: TextStyle(fontSize: 18),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Slidable(
                          key: ValueKey(item.produk.id),
                          endActionPane: ActionPane(
                            motion: const DrawerMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (_) => cart.removeItem(item.produk),
                                backgroundColor: Colors.redAccent,
                                icon: Icons.delete,
                                label: 'Hapus',
                              ),
                            ],
                          ),
                          child: Container(
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
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  item.produk.imagePath,
                                  width: 55,
                                  height: 55,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      const Icon(Icons.image_not_supported),
                                ),
                              ),
                              title: Text(
                                item.produk.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                '${item.produk.getFormattedPrice()} × ${item.quantity}',
                              ),
                              trailing: Text(
                                'Rp ${item.totalPrice.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Bagian total harga
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, -3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Rp ${cart.totalPrice.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ),
                // Tombol Checkout dengan animasi centang
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: cart.items.isEmpty
                        ? null
                        : () {
                            _showReceiptBottomSheet(context, cart, purchase);
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 251, 112, 112),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      transitionBuilder: (child, animation) =>
                          ScaleTransition(scale: animation, child: child),
                      child: _showSuccess
                          ? ScaleTransition(
                              scale: CurvedAnimation(
                                parent: _checkController,
                                curve: Curves.elasticOut,
                              ),
                              child: const Icon(
                                Icons.check_circle,
                                key: ValueKey('check'),
                                color: Colors.white,
                                size: 26,
                              ),
                            )
                          : const Text(
                              'Checkout Sekarang',
                              key: ValueKey('text'),
                              style: TextStyle(fontSize: 18),
                            ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  void _showReceiptBottomSheet(
    BuildContext context,
    CartProvider cart,
    PurchaseProvider purchase,
  ) {
    final items = List<CartItem>.from(cart.items);
    final total = cart.totalPrice;

    purchase.addPurchase(items);
    cart.clear();
    _triggerSuccessAnimation(); // 🟢 tampilkan animasi centang

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.75,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 50,
                      height: 5,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const Text(
                    '🧾 Ringkasan Pesanan',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F8F8),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              item.produk.imagePath,
                              width: 45,
                              height: 45,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  const Icon(Icons.image_not_supported),
                            ),
                          ),
                          title: Text(
                            item.produk.name,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            '${item.quantity} × ${item.produk.getFormattedPrice()}',
                          ),
                          trailing: Text(
                            'Rp ${item.totalPrice.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.redAccent,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Pembayaran',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Rp ${total.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                        context,
                        '/checkout',
                        arguments: {'items': items, 'total': total},
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Beli', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
