// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:frontend/screens/core/book.dart';
import 'package:frontend/screens/core/profile.dart';
import 'package:frontend/screens/home.dart';

class ListDetail extends StatelessWidget {
  final Profile profile;

  const ListDetail({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Profile Details",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontFamily: 'Outfit'),
        ),
        shadowColor: Colors.grey.withOpacity(0.5),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(profile.imagePath),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                profile.name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Outfit',
                  shadows: [
                    Shadow(
                      offset: Offset(0, 2),
                      blurRadius: 3.0,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: profile.gender == 'Male'
                          ? Color.fromARGB(255, 110, 227, 240)
                          : Color.fromARGB(255, 248, 157, 188),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          profile.gender == 'Male' ? Icons.male : Icons.female,
                          color: Colors.black,
                        ),
                        SizedBox(width: 5),
                        Text(
                          profile.gender,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.label, size: 20, color: Colors.purple),
                      const SizedBox(width: 4),
                      Text(
                        profile.description,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                'About',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Outfit',
                ),
              ),
              Text(
                profile.about,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Interest',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w800,
                ),
              ),
              Wrap(
                spacing: 10,
                runSpacing: 3,
                children: [
                  InterestChip(label: 'Explosives'),
                  InterestChip(label: 'Arson'),
                  InterestChip(label: 'Curios'),
                  InterestChip(label: 'Howling'),
                  InterestChip(label: 'Scary Movies'),
                  InterestChip(label: 'Gardening'),
                ],
              ),
              SizedBox(height: 30),
              Text(
                'Photo Album',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Outfit',
                ),
              ),
              SizedBox(height: 10),
              PhotoAlbum(photos: [
                profile.imagePath,
                'assets/images/iqbal.jpeg',
                'assets/images/iqbal.jpeg',
              ]),
              SizedBox(height: 30),
              Text(
                'Reviews',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Outfit'),
              ),
              ReviewSection(reviews: [
                Review(
                  text: "Bagus dia ramah",
                  rating: 5,
                  profileImage: 'assets/images/profile1.jpg',
                  reviewerName: 'John Doe',
                  reviewDate: '2024-01-01',
                ),
                Review(
                  text: "Menyenangkan dan sangat membantu",
                  rating: 4,
                  profileImage: 'assets/images/profile2.jpg',
                  reviewerName: 'Jane Smith',
                  reviewDate: '2024-01-02',
                ),
                Review(
                  text: "Cukup baik, tapi bisa lebih baik lagi",
                  rating: 3,
                  profileImage: 'assets/images/profile3.jpg',
                  reviewerName: 'Alice Johnson',
                  reviewDate: '2024-01-03',
                ),
              ]),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Container(
          height: 60.0,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DoctorDetailPage(profile: profile)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF73C3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  shadowColor: Colors.grey.withOpacity(0.5),
                  elevation: 5,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50.0,
                    vertical: 15.0,
                  ),
                  child: Text(
                    "Book Now",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontFamily: 'Outfit',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _bookProfile(BuildContext context, Profile profile) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Booking"),
          content: Text("Booking profile for ${profile.name}."),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class InterestChip extends StatelessWidget {
  final String label;

  InterestChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: _getChipColor(label),
      labelStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontFamily: 'Outfit',
        shadows: [
          Shadow(
            offset: Offset(0, 2),
            blurRadius: 3.0,
            color: Colors.grey.withOpacity(0.5),
          ),
        ],
      ),
      elevation: 3,
      shadowColor: Colors.black.withOpacity(0.2),
    );
  }

  Color _getChipColor(String label) {
    switch (label) {
      case 'Explosives':
        return const Color.fromARGB(255, 200, 108, 216);
      case 'Arson':
        return const Color.fromARGB(255, 250, 188, 95);
      case 'Curios':
        return Color.fromARGB(255, 107, 203, 248);
      case 'Howling':
        return const Color.fromARGB(255, 255, 241, 112);
      case 'Scary Movies':
        return const Color.fromARGB(255, 189, 246, 125);
      case 'Gardening':
        return const Color.fromARGB(255, 239, 94, 143);
      default:
        return Colors.grey;
    }
  }
}

class PhotoAlbum extends StatelessWidget {
  final List<String> photos;

  const PhotoAlbum({required this.photos});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: photos.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(right: 10),
            width: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(photos[index]),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ReviewSection extends StatelessWidget {
  final List<Review> reviews;

  const ReviewSection({required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: reviews.map((review) => _buildReview(review)).toList(),
    );
  }

  Widget _buildReview(Review review) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(review.profileImage),
            radius: 20,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  review.reviewerName,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Outfit',
                  ),
                ),
                Text(
                  review.reviewDate,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  review.text,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < review.rating ? Icons.star : Icons.star_border,
                color: Colors.yellow,
              );
            }),
          ),
        ],
      ),
    );
  }
}

class Review {
  final String text;
  final int rating;
  final String profileImage;
  final String reviewerName;
  final String reviewDate;

  Review({
    required this.text,
    required this.rating,
    required this.profileImage,
    required this.reviewerName,
    required this.reviewDate,
  });
}
