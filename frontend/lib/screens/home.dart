import 'package:flutter/material.dart';
import 'package:frontend/screens/auth/sign_in.dart';
import 'package:frontend/screens/core/chat.dart';
import 'package:frontend/screens/core/list_chat.dart';
import 'package:frontend/screens/core/list_details.dart';
import 'package:frontend/screens/core/order.dart';
import 'package:frontend/screens/core/profile.dart';
import 'package:frontend/screens/core/book.dart'; // Import the doctor detail page
import 'package:frontend/services/token_storage.dart';
import 'package:frontend/widgets/menu_bar.dart';

// Const for strings
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
  final List<Profile> profiles = [
    const Profile(
      imagePath: 'assets/images/natayow.jpeg',
      name: 'Natayow',
      description: 'Charming',
      about: 'Gw minat besar pada film tentang hacking dan kejahatan komputer.',
      gender: 'Female',
    ),
    const Profile(
      imagePath: 'assets/images/jamet.jpeg',
      name: 'Rayhan Diffa',
      description: 'Soft Boy',
      about: 'Aku memang pencinta wanita namun ku bukan buaya.',
      gender: 'Lady Boy',
    ),
    const Profile(
      imagePath: 'assets/images/kennoy.jpeg',
      name: 'Ahmad Yusuf',
      description: 'Fragile Boy',
      about:
          'Saya baru mualaf beberapa bulan lalu, saya senang memancing dan saya rapuh.',
      gender: 'Male',
    ),
    const Profile(
      imagePath: 'assets/images/iqbal.jpeg',
      name: 'Iqbal Saputra',
      description: 'Handsome Boy',
      about:
          'Enthusiast film dan teknologi. Gw selalu penuh energi dan ide-ide kreatif.',
      gender: 'Male',
    ),
    const Profile(
      imagePath: 'assets/images/kennoy2.jpeg',
      name: 'Kenny Ekenayake',
      description: 'Fun',
      about: 'Seorang penggemar kuliner yang lahir di BSD Lama.',
      gender: 'Female',
    ),
    const Profile(
      imagePath: 'assets/images/adrian.jpeg',
      name: 'Adrian Rachman',
      description: 'Wibu Boy',
      about: 'Wibu akut yang selalu pergi ke event wibu.',
      gender: 'Male',
    ),
    const Profile(
      imagePath: 'assets/images/jamet2.jpeg',
      name: 'Jammedun Hakim',
      description: 'Fun',
      about: 'Berjiwa petualang dan menyukai olahraga luar ruangan.',
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
      _username = userData['username'] ?? 'Guest';
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
                'Halo, ${_username ?? 'Guest'}',
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
                  ? ListChat()
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
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.bold),
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
                  'SleepCall',
                  'Teman Curhat',
                  'Kondangan',
                  'Holiday Events',
                  'Teman Ibadah',
                  'More'
                ];

                final iconPaths = [
                  'assets/icons/sleepcall.jpeg',
                  'assets/icons/tmncurhat2.jpeg',
                  'assets/icons/kondangan.jpeg',
                  'assets/icons/holiday.jpeg',
                  'assets/icons/temanibadah.jpeg',
                  'assets/icons/more.jpeg'
                ];

                return ServiceCategory(
                  iconPath: iconPaths[index],
                  label: serviceCategories[index],
                );
              },
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
              itemCount: profiles.length,
              itemBuilder: (context, index) {
                final profile = profiles[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: GestureDetector(
                    child: ProfileCard(profile: profile),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListDetail(profile: profile),
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
  final String about;

  const Profile({
    required this.imagePath,
    required this.name,
    required this.description,
    required this.gender,
    required this.about,
  });
}

class ProfileCard extends StatelessWidget {
  final Profile profile;

  const ProfileCard({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(9.0),
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
              width: 100,
              height: 100,
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
                    Icon(
                      profile.gender.toLowerCase() == 'male'
                          ? Icons.male
                          : Icons.female,
                      size: 16,
                      color: profile.gender.toLowerCase() == 'male'
                          ? Colors.blue
                          : Colors.pink,
                    ),
                    const SizedBox(width: 4),
                    Text(profile.gender),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  profile.about,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                ),
              ],
            ),
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
