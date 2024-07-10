import 'package:flutter/material.dart';
import 'package:frontend/screens/auth/sign_in.dart';
import 'package:frontend/screens/core/companion_details.dart';
import 'package:frontend/screens/core/order.dart';
import 'package:frontend/screens/core/profile.dart';
import 'package:frontend/services/token_storage.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/widgets/menu_bar.dart';
import 'package:frontend/widgets/companion_card.dart';
import 'package:frontend/widgets/service_category.dart';

const String popularServices = 'Services Paling Laku';
const String ordersPage = 'Orders Page';
const String profilePage = 'Profile Page';
const String recommendedGamers = 'Paling Banyak Digandrungi';

class Home extends StatefulWidget {
  final Map<String, dynamic>? userData;

  const Home({Key? key, this.userData}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TokenStorage _tokenStorage = TokenStorage();
  final ApiService _apiService = ApiService();
  List<dynamic> _companions = [];
  int _selectedIndex = 0;
  String? _username;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _fetchCompanions();
  }

  Future<void> _loadUserData() async {
    final userData = await _tokenStorage.getUserData();
    setState(() {
      _username = userData['username'] ?? 'Guest';
    });
  }

  Future<void> _fetchCompanions() async {
    final companions = await _apiService.getCompanions();
    setState(() {
      _companions = companions ?? [];
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _signOut() async {
    try {
      await _tokenStorage.clearUserData();
      _navigateToSignIn();
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  void _navigateToSignIn() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SignIn()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0
          ? AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                'Halo, ${widget.userData?['username'] ?? _username ?? 'Guest'}',
                style: const TextStyle(
                    color: Colors.black,
                    fontFamily: "Outfit",
                    fontWeight: FontWeight.w600),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.black),
                  onPressed: () {},
                  tooltip: 'Search',
                ),
              ],
            )
          : null,
      body: _selectedIndex == 0
          ? _buildHomeContent()
          : _selectedIndex == 1
              ? MyBookingsPage()
              : _selectedIndex == 2
                  ? const ProfileScreen()
                  : const ProfileScreen(),
      bottomNavigationBar: CustomMenuBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage(
                      'assets/images/banner1.png'), // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
              height: 200, // Adjust the height as needed
            ),
            const SizedBox(height: 20),
            const Text(
              recommendedGamers,
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Outfit",
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _companions.length,
              itemBuilder: (context, index) {
                final companion = _companions[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: GestureDetector(
                    child: CompanionCard(companion: companion),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CompanionDetails(companion: companion),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
