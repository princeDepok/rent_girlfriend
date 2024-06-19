import 'package:flutter/material.dart';
import 'package:frontend/screens/auth/sign_in.dart';
import 'package:frontend/screens/core/chat.dart';
import 'package:frontend/screens/core/profile.dart';
import 'package:frontend/services/token_storage.dart';
import 'package:frontend/widgets/menu_bar.dart';

// Const for strings
const String popularServices = 'Popular Services';
const String ordersPage = 'Orders Page';
const String profilePage = 'Profile Page';
const String recommendedGamers = 'Recommended Gamers';

class Home extends StatefulWidget {
  final Map<String, dynamic> userData;

  const Home({Key? key, required this.userData}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TokenStorage _tokenStorage = TokenStorage();
  final List<Profile> profiles = [
    const Profile(
      imagePath: 'assets/images/iqbal.jpeg',
      name: 'Natayow',
      description: 'Charming',
      gender: 'Female',
    ),
    const Profile(
      imagePath: 'assets/images/iqbal.jpeg',
      name: 'Rayhan Diffa',
      description: 'Soft Boy',
      gender: 'Lady Boy',
    ),
    const Profile(
      imagePath: 'assets/images/iqbal.jpeg',
      name: 'Kenny Ekenayake',
      description: 'Fragile Boy',
      gender: 'Female',
    ),
    const Profile(
      imagePath: 'assets/images/iqbal.jpeg',
      name: 'Iqbal Saputra',
      description: 'Handsome Boy',
      gender: 'Male',
    ),
    const Profile(
      imagePath: 'assets/images/iqbal.jpeg',
      name: 'Swill Sefarty',
      description: 'Fun',
      gender: 'Female',
    ),
    const Profile(
      imagePath: 'assets/images/iqbal.jpeg',
      name: 'Iqbal Saputra',
      description: 'Handsome Boy',
      gender: 'Female',
    ),
    const Profile(
      imagePath: 'assets/images/iqbal.jpeg',
      name: 'Swill Sefarty',
      description: 'Fun',
      gender: 'Male',
    ),
  ];

  int _selectedIndex = 0;
  String? _username;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await _tokenStorage.getUserData();
    setState(() {
      _username = userData['username'];
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _signOut() async {
    try {
      await _tokenStorage.deleteTokens();
      _navigateToSignIn();
    } catch (e) {
      // Handle error, e.g., show a Snackbar
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
                'Halo, ${_username ?? 'N/A'}',
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
              ? _buildOrdersContent()
              : _selectedIndex == 2
                  ? const Chat()
                  : _selectedIndex == 3
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
              popularServices,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final serviceCategories = [
                  'Mobile Legends',
                  'Teman Curhat',
                  'PUBG',
                  'Free Fire',
                  'Ludo King',
                  'More'
                ];
                return ServiceCategory(
                  iconPath: 'assets/images/iqbal.jpeg',
                  label: serviceCategories[index],
                );
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sure Win',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const Text('Refund if you don’t win'),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Go'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Flash Order Rizzzz',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text('Open Now'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.purple[100],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Host Order Service',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text('Open Now'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              recommendedGamers,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: profiles.length,
              itemBuilder: (context, index) {
                final profile = profiles[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: GestureDetector(
                    child: ProfileCard(profile: profile),
                    onTap: () {},
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrdersContent() {
    return const Center(
      child: Text(
        ordersPage,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildProfileContent() {
    return const Center(
      child: Text(
        profilePage,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class Profile {
  final String imagePath;
  final String name;
  final String description;
  final String gender;

  const Profile({
    required this.imagePath,
    required this.name,
    required this.description,
    required this.gender,
  });
}

class ProfileCard extends StatelessWidget {
  final Profile profile;

  const ProfileCard({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              profile.imagePath,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.label, size: 16, color: Colors.purple),
                    const SizedBox(width: 4),
                    Text(profile.description),
                    const SizedBox(width: 8),
                    const Icon(Icons.male, size: 16, color: Colors.blue),
                    const SizedBox(width: 4),
                    Text(profile.gender),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Tier ready GM-Honor..',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              const Icon(Icons.circle, size: 12, color: Colors.green),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: const Text(
                  '12"',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ServiceCategory extends StatelessWidget {
  final String iconPath;
  final String label;

  const ServiceCategory({required this.iconPath, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 75,
          height: 75,
          decoration: BoxDecoration(
            color: Colors.red[100],
            borderRadius: BorderRadius.circular(34),
            image: DecorationImage(
              image: AssetImage(iconPath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, textAlign: TextAlign.center),
      ],
    );
  }
}
