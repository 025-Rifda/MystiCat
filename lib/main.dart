import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'splash_page.dart';
import 'providers/cart_provider.dart';
import 'providers/purchase_provider.dart';
import 'providers/user_provider.dart';
import 'sign_up_page.dart';
import 'login_page.dart';
import 'dashboard_page.dart';
import 'cart_page.dart';
import 'profile_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Hive.initFlutter();
    await Hive.openBox('cartBox');
    await Hive.openBox('purchaseBox');
    await Hive.openBox('userBox'); // ✅ buka box di sini, sebelum runApp
  } catch (e) {
    debugPrint('❌ Gagal inisialisasi Hive: $e');
  }

  runApp(const MystiCatApp());
}

class MystiCatApp extends StatelessWidget {
  const MystiCatApp({super.key});

  @override
  Widget build(BuildContext context) {
    final userBox = Hive.box('userBox');

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => PurchaseProvider()),
        ChangeNotifierProvider(
          create: (_) => UserProvider(userBox),
        ), // ✅ user provider terima box
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MystiCat',
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Poppins',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
        ),
        initialRoute: '/splash',
        routes: {
          '/splash': (_) => const SplashScreen(),
          '/login': (_) => const LoginPage(),
          '/signup': (_) => const SignUpPage(),
          '/dashboard': (_) => const DashboardPage(),
          '/cart': (_) => const CartPage(),
          '/profile': (_) => const ProfilePage(),
        },
      ),
    );
  }
}
