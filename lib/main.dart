import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'splash_page.dart';
import 'providers/cart_provider.dart';
import 'providers/purchase_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => PurchaseProvider()),
      ],
      child: const MystiCatApp(),
    ),
  );
}

class MystiCatApp extends StatelessWidget {
  const MystiCatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MystiCat',
      home: SplashScreen(),
    );
  }
}
