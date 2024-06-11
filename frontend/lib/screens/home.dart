import 'package:flutter/material.dart';
import 'package:frontend/screens/auth/sign_in.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/services/token_storage.dart';

class Home extends StatefulWidget {
  final Map<String, dynamic> userData;

  const Home({Key? key, required this.userData}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ApiService _apiService = ApiService();
  final TokenStorage _tokenStorage = TokenStorage();

  // Sign out function
  Future<void> _signOut() async {
    await _tokenStorage.deleteTokens();
    _navigateToSignIn();
  }

  // Navigate to SignIn screen
  void _navigateToSignIn() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignIn()));
  }

  @override
  Widget build(BuildContext context) {
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
        child: ListView(
          children: [
            Text('Username: ${widget.userData['username']}'),
            Text('Email: ${widget.userData['email']}'),
            Text('First Name: ${widget.userData['first_name']}'),
            Text('Last Name: ${widget.userData['last_name']}'),
            Text('Phone Number: ${widget.userData['phone_number']}'),
            Text('Gender: ${widget.userData['gender']}'),
            Text('Birth Place: ${widget.userData['birth_place']}'),
            Text('Birth Date: ${widget.userData['birth_date']}'),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _signOut,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 24.0),
              ),
              child: const Text('Sign Out', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
