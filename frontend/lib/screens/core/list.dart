// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:frontend/screens/auth/sign_in.dart';
import 'package:frontend/screens/core/list_details.dart';
import 'package:frontend/services/token_storage.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
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

  // Navigate to SignIn screen
  void _navigateToListDetail() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ListDetail()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 25, right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 54),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'List of Pacar',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Container(
                  height: 38,
                  width: 340,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 4),
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 4)
                      ]),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(9, 8, 60, 9),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Cari Pacar Lagi',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: Color(0xff797979),
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'Names List',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: profiles.length,
                itemBuilder: (context, index) {
                  final profile = profiles[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: GestureDetector(
                        child: ProfileCard(profile: profile),
                        onTap: _navigateToListDetail),
                  );
                },
              ),
            ),
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
