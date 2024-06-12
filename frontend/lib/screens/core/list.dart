import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final List<Profile> profiles = [
    Profile('assets/image1.png', 'Natayow', 'Charming', 'Female'),
    Profile('assets/image2.png', 'Rayhan Diffa', 'Soft Boy', 'Male'),
    Profile('assets/image3.png', 'Kenny Ekenayake', 'Fragile Boy', 'Female'),
    Profile('assets/image4.png', 'Iqbal Saputra', 'Handsome Boy', 'Male'),
    Profile('assets/image5.png', 'Swill Sefarty', 'Fun', 'Female'),
    Profile('assets/image4.png', 'Iqbal Saputra', 'Handsome Boy', 'Female'),
    Profile('assets/image5.png', 'Swill Sefarty', 'Fun', 'Male'),
  ];

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
                    child: ProfileCard(profile: profile),
                  );
                },
              ),
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
          CircleAvatar(
            backgroundImage: AssetImage(profile.imagePath),
            radius: 30,
            onBackgroundImageError: (exception, stackTrace) {
              print('Error loading image: ${profile.imagePath}');
            },
          ),
          SizedBox(width: 16),
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
                Text(
                  profile.description,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: profile.gender == 'Male' ? Colors.blue : Colors.pink,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                profile.gender,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
