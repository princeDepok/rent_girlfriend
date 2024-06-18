import 'package:flutter/material.dart';
import 'package:frontend/screens/auth/sign_in.dart';
import 'package:frontend/screens/auth/sign_up.dart';
import 'package:frontend/screens/core/list.dart';
// import 'package:frontend/screens/core/list.dart';
import 'package:frontend/screens/core/list_details.dart';
import 'package:frontend/screens/home.dart';
import 'package:frontend/screens/splash.dart';
import 'package:frontend/services/token_storage.dart';
// import 'package:frontend/screens/core/list.dart';
// import 'package:frontend/screens/core/test.dart';
// import 'package:frontend/screens/auth/sign_up.dart';
// import 'package:frontend/screens/core/list_details.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
