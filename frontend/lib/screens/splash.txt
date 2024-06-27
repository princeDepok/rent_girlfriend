import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/screens/auth/sign_in.dart';
import 'package:frontend/screens/home.dart';
import '../../services/api_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final ApiService _apiService = ApiService();
  bool isLoggedIn = false;
  Map<String, dynamic> userData = {};

  Future<void> loginState() async {
    String? accessToken = await _secureStorage.read(key: "access");
    if (accessToken != null) {
      print('Access token found: $accessToken');
      try {
        String? userId = await _secureStorage.read(key: "userId");
        if (userId != null) {
          print('User ID found: $userId');
          final response =
              await _apiService.getUserDetails(int.parse(userId), accessToken);
          if (response.statusCode == 200) {
            setState(() {
              isLoggedIn = true;
              userData = response.data;
            });
            print('User data retrieved: $userData');
          } else {
            print('Failed to retrieve user data: ${response.statusCode}');
          }
        } else {
          print('User ID not found.');
        }
      } catch (e) {
        print('Error retrieving user data: $e');
      }
    } else {
      print('Access token not found.');
    }
  }

  @override
  void initState() {
    super.initState();
    loginState().then((_) async {
      final savedUserData = await _secureStorage.readAll();
      Timer(
        const Duration(seconds: 4),
        () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                isLoggedIn ? Home(userData: savedUserData) : const SignIn(),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
