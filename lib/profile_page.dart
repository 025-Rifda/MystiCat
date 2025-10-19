import 'package:flutter/material.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:provider/provider.dart';
import 'purchase_history_page.dart';
import 'providers/user_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double _rating = 0;
  final TextEditingController _reviewController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final Color primaryColor = const Color.fromARGB(255, 251, 112, 112);
  final Color lightPink = const Color(
    0xFFFBD3D3,
  ); // soft pink untuk item normal
  final Color softBackground = const Color(0xFFFDF6F9);

  String _username = "";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    setState(() {
      _username = userProvider.username;
    });
  }

  Future<void> _saveUserData(String username, String password) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.setUsername(username);
    setState(() {
      _username = username;
    });
  }

  void _showReviewModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Beri Ulasan",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              RatingBar(
                filledIcon: Icons.star,
                emptyIcon: Icons.star_border,
                onRatingChanged: (value) {
                  setState(() {
                    _rating = value;
                  });
                },
                size: 35,
                maxRating: 5,
                filledColor: primaryColor,
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _reviewController,
                decoration: InputDecoration(
                  hintText: "Tulis komentar kamu...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: primaryColor.withOpacity(0.5),
                    ),
                  ),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 25,
                  ),
                ),
                onPressed: () {
                  _reviewController.clear();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: primaryColor,
                      content: Text(
                        "Terima kasih atas ulasannya! ⭐ $_rating",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Kirim Ulasan",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showEditProfileModal() {
    _nameController.text = _username;
    _passwordController.text = "";

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Edit Profil",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Nama",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: primaryColor.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: primaryColor.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 25,
                  ),
                ),
                onPressed: () async {
                  await _saveUserData(
                    _nameController.text,
                    _passwordController.text,
                  );
                  Navigator.pop(context); // Tutup modal edit
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Profil berhasil diperbarui ✅"),
                    ),
                  );
                },
                child: const Text(
                  "Simpan",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildListItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    required bool isHighlighted,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          color: isHighlighted ? primaryColor : lightPink,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 255, 168, 168).withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 24,
              child: Icon(
                icon,
                color: isHighlighted ? primaryColor : Colors.pink[300],
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isHighlighted ? Colors.white : primaryColor,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: isHighlighted ? Colors.white : primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: softBackground,
      appBar: AppBar(
        title: const Text("Profil"),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            CircleAvatar(
              radius: 55,
              backgroundColor: Colors.white,
              backgroundImage: const AssetImage('assets/icon/icon.png'),
            ),
            const SizedBox(height: 12),
            Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                return Text(
                  userProvider.username,
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                );
              },
            ),
            const SizedBox(height: 25),

            // === List menu seperti desain ===
            _buildListItem(
              title: "Edit Profil",
              icon: Icons.edit,
              isHighlighted: false,
              onTap: _showEditProfileModal,
            ),
            _buildListItem(
              title: "Riwayat Pembelian",
              icon: Icons.history,
              isHighlighted: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PurchaseHistoryPage(),
                  ),
                );
              },
            ),
            _buildListItem(
              title: "Beri Ulasan",
              icon: Icons.rate_review,
              isHighlighted: false,
              onTap: _showReviewModal,
            ),
            _buildListItem(
              title: "Logout",
              icon: Icons.logout,
              isHighlighted: true,
              onTap: () {
                Navigator.pop(context);
              },
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
