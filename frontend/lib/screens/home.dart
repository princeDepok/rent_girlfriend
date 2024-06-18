import 'package:flutter/material.dart';
import 'package:frontend/screens/auth/sign_in.dart';
import 'package:frontend/services/token_storage.dart';

class Home extends StatefulWidget {
  final Map<String, dynamic> userData;

  const Home({Key? key, required this.userData}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TokenStorage _tokenStorage = TokenStorage();

  // Sign out function
  Future<void> _signOut() async {
    await _tokenStorage.deleteTokens();
    _navigateToSignIn();
  }

  // Navigate to SignIn screen
  void _navigateToSignIn() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SignIn()));
  }

  @override
  Widget build(BuildContext context) {
    // Check if userData is empty and handle accordingly
    Map<String, dynamic> userData = widget.userData.isNotEmpty
        ? widget.userData
        : {
            'username': 'N/A',
            'email': 'N/A',
            'first_name': 'N/A',
            'last_name': 'N/A',
            'phone_number': 'N/A',
            'gender': 'N/A',
            'birth_place': 'N/A',
            'birth_date': 'N/A'
          };

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _signOut,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Halo, ${userData['username']}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildUserInfo('Username', userData['username']),
                    _buildUserInfo('Email', userData['email']),
                    _buildUserInfo('First Name', userData['first_name']),
                    _buildUserInfo('Last Name', userData['last_name']),
                    _buildUserInfo('Phone Number', userData['phone_number']),
                    _buildUserInfo('Gender', userData['gender']),
                    _buildUserInfo('Birth Place', userData['birth_place']),
                    _buildUserInfo('Birth Date', userData['birth_date']),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _signOut,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 24.0),
                ),
                child: const Text('Sign Out', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
