import 'package:flutter/material.dart';
import 'package:frontend/screens/auth/sign_in.dart';
import 'package:frontend/screens/core/profile.dart';
import 'package:frontend/services/token_storage.dart';

class Home extends StatefulWidget {
  final Map<String, dynamic> userData;

  const Home({Key? key, required this.userData}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TokenStorage _tokenStorage = TokenStorage();
  final List<Profile> profiles = [
    Profile('assets/images/iqbal.jpeg', 'Natayow', 'Charming', 'Female'),
    Profile('assets/images/iqbal.jpeg', 'Rayhan Diffa', 'Soft Boy', 'Lady Boy'),
    Profile(
        'assets/images/iqbal.jpeg', 'Kenny Ekenayake', 'Fragile Boy', 'Female'),
    Profile(
        'assets/images/iqbal.jpeg', 'Iqbal Saputra', 'Handsome Boy', 'Male'),
    Profile('assets/images/iqbal.jpeg', 'Swill Sefarty', 'Fun', 'Female'),
    Profile(
        'assets/images/iqbal.jpeg', 'Iqbal Saputra', 'Handsome Boy', 'Female'),
    Profile('assets/images/iqbal.jpeg', 'Swill Sefarty', 'Fun', 'Male'),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _signOut() async {
    await _tokenStorage.deleteTokens();
    _navigateToSignIn();
  }

  void _navigateToSignIn() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SignIn()));
  }

  @override
  Widget build(BuildContext context) {
    String username = widget.userData['username'] ?? 'N/A';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Halo, $username',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: _selectedIndex == 0
          ? _buildHomeContent()
          : _selectedIndex == 1
              ? _buildOrdersContent()
              : ProfileScreen(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
        onTap: _onItemTapped,
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
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/banner1.png'), // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
              height: 200, // Adjust the height as needed
            ),
            const SizedBox(height: 20),
            Text(
              'Popular Services',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _buildServiceCategory(
                    'assets/images/iqbal.jpeg', 'Mobile Legends'),
                _buildServiceCategory(
                    'assets/images/iqbal.jpeg', 'Teman Curhat'),
                _buildServiceCategory('assets/images/iqbal.jpeg', 'PUBG'),
                _buildServiceCategory('assets/images/iqbal.jpeg', 'Free Fire'),
                _buildServiceCategory('assets/images/iqbal.jpeg', 'Ludo King'),
                _buildServiceCategory('assets/images/iqbal.jpeg', 'More'),
              ],
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
                        Text(
                          'Sure Win',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text('Refund if you don’t win'),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Go'),
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
                        child: Column(
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
                        child: Column(
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
            Text(
              'Recommended Gamers',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
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
    return Center(
      child: Text(
        'Orders Page',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildProfileContent() {
    return Center(
      child: Text(
        'Profile Page',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildServiceCategory(String iconPath, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.red[100],
          backgroundImage: AssetImage(iconPath),
        ),
        SizedBox(height: 8),
        Text(label, textAlign: TextAlign.center),
      ],
    );
  }
}

class Profile {
  final String imagePath;
  final String name;
  final String description;
  final String gender;

  Profile(this.imagePath, this.name, this.description, this.gender);
}

class ProfileCard extends StatelessWidget {
  final Profile profile;

  ProfileCard({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
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
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.label, size: 16, color: Colors.purple),
                    SizedBox(width: 4),
                    Text(profile.description),
                    SizedBox(width: 8),
                    Icon(Icons.male, size: 16, color: Colors.blue),
                    SizedBox(width: 4),
                    Text(profile.gender),
                  ],
                ),
                SizedBox(height: 4),
                Text(
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
              Icon(Icons.circle, size: 12, color: Colors.green),
              SizedBox(height: 4),
              Container(
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
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
