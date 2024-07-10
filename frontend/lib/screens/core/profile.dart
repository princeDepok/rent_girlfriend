import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/screens/auth/sign_in.dart';
import 'package:frontend/screens/auth/sign_up.dart';
import 'package:frontend/screens/home.dart';
import 'package:frontend/services/token_storage.dart';
import 'package:frontend/services/api_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final TokenStorage _tokenStorage = TokenStorage();
  final ApiService _apiService = ApiService();

  String? _userName;
  String? _gender;
  bool _isCompanion = false;
  bool _isUserDataLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _signOut() async {
    await _tokenStorage.clearUserData();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Home()), // Navigate to Home
    );
  }

  Future<void> _loadUserData() async {
    final userData = await _tokenStorage.getUserData();
    setState(() {
      _userName = userData['username'];
      _gender = userData['gender'];
      _isCompanion = userData['is_companion'] == 'true';
      _isUserDataLoaded = true;
    });
  }

  String get genderText {
    if (_gender == 'Laki-laki') {
      return 'Lanang';
    } else if (_gender == 'Wanita') {
      return 'Wedok';
    } else {
      return 'Unknown';
    }
  }

  IconData get genderIcon {
    if (_gender == 'Laki-laki') {
      return Icons.male;
    } else if (_gender == 'Wanita') {
      return Icons.female;
    } else {
      return Icons.help;
    }
  }

  void _showFullImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(10),
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


  void _navigateToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile',
            style: TextStyle(
                fontFamily: 'Outfit', fontWeight: FontWeight.w700)),
      ),
      body: _isUserDataLoaded
          ? (_userName != null)
              ? Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          InkWell(
                            onTap: () => _showFullImage(context),
                            child: const CircleAvatar(
                              radius: 60,
                              backgroundImage:
                                  AssetImage('assets/images/iqbal.jpeg'),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _userName!,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.w600),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(genderIcon, color: Colors.black),
                              const SizedBox(width: 8),
                              Text(
                                genderText,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Outfit',
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
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
                          const Divider(),
                          _buildMenuItem(
                            context,
                            title: 'Languages',
                            onTap: () {
                              // Navigate to Languages screen
                            },
                          ),
                          const Divider(),
                          _buildMenuItem(
                            context,
                            title: 'App Information',
                            onTap: () {
                              // Navigate to App Information screen
                            },
                          ),
                          const Divider(),
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12),
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
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'You are not logged in.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Outfit',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignIn()),
                            );
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
                              'Sign In',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Outfit',
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: _navigateToSignUp,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Outfit',
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
          : const Center(
              child: CircularProgressIndicator(),
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
