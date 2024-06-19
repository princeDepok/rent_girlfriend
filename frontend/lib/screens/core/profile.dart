// lib/screens/core/profile.dart

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
      body: Column(
        children: [
          Container(
            color: Colors.purple,
            child: Column(
              children: [
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                      'assets/images/iqbal.jpeg'), // Change this to the correct path
                ),
                SizedBox(height: 10),
                Text(
                  'Push Puttichai',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text('Password'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    // Navigate to Password screen
                  },
                ),
                Divider(),
                ListTile(
                  title: Text('Touch ID'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    // Navigate to Touch ID screen
                  },
                ),
                Divider(),
                ListTile(
                  title: Text('Languages'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    // Navigate to Languages screen
                  },
                ),
                Divider(),
                ListTile(
                  title: Text('App information'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    // Navigate to App information screen
                  },
                ),
                Divider(),
                ListTile(
                  title: Text('Customer care'),
                  trailing: Text('19008989'),
                  onTap: () {
                    // Navigate to Customer care screen
                  },
                ),
                Divider(),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: _signOut,
              child: const Text('Sign Out'),
            ),
          ),
        ],
      ),
    );
  }
}
