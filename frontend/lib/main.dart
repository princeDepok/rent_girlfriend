import 'package:flutter/material.dart';
import 'package:frontend/screens/auth/sign_up.dart';
import 'package:frontend/screens/core/order_summary.dart';
import 'package:frontend/screens/splash.dart';

String? jwt;

Future<void> main() async {
  // final TokenStorage _tokenStorage = TokenStorage();
  // jwt = await _tokenStorage.getAccessToken();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF73C3)),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
