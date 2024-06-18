import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/screens/auth/sign_in.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> _signOut() async {
    // Delete stored tokens
    await _secureStorage.delete(key: 'access');
    await _secureStorage.delete(key: 'refresh');

    // Navigate to sign-in screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignIn()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _signOut,
          child: const Text('Sign Out'),
        ),
      ),
    );
  }
}
