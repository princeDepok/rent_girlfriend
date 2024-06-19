// lib/screens/core/profile.dart

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/screens/auth/sign_in.dart';
import 'package:frontend/services/token_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final TokenStorage _tokenStorage = TokenStorage();

  String? _firstName;
  String? _lastName;
  String? _userName;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _signOut() async {
    await _secureStorage.delete(key: 'access');
    await _secureStorage.delete(key: 'refresh');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignIn()),
    );
  }

  Future<void> _loadUserData() async {
    final userData = await _tokenStorage.getUserData();
    setState(() {
      _firstName = userData['first_name'];
      _lastName = userData['last_name'];
      _userName = userData['username'];
    });
  }

  void _showFullImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: InteractiveViewer(
              child: Image.asset('assets/images/iqbal.jpeg'),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile',
            style:
                TextStyle(fontFamily: 'Outfit', fontWeight: FontWeight.w600)),
      ),
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                const SizedBox(height: 20),
                InkWell(
                  onTap: () => _showFullImage(context),
                  child: const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/iqbal.jpeg'),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '$_firstName $_lastName',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  '$_userName',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildMenuItem(
                  context,
                  title: 'Edit Profile',
                  onTap: () {
                    // Navigate to Edit Profile screen
                  },
                ),
                Divider(),
                _buildMenuItem(
                  context,
                  title: 'Languages',
                  onTap: () {
                    // Navigate to Languages screen
                  },
                ),
                Divider(),
                _buildMenuItem(
                  context,
                  title: 'App Information',
                  onTap: () {
                    // Navigate to App Information screen
                  },
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to Companion screen
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Go to Companion',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Outfit',
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                GestureDetector(
                  onTap: _signOut,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Sign Out',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context,
      {required String title, required VoidCallback onTap}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontFamily: 'Outfit', fontSize: 16),
          ),
          GestureDetector(
            onTap: onTap,
            child: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
