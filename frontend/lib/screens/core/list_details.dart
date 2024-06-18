// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ListDetail extends StatefulWidget {
  @override
  State<ListDetail> createState() => _ListDetailState();
}

class _ListDetailState extends State<ListDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/iqbal.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Fester A.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Age: 31',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 30),
              Text(
                'About',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'Greetings fellow weirdo, my name is Fester. If you\'re looking for a strange and unusual time, then look no further.',
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
                ),
              ),
              SizedBox(height: 10),
              PhotoAlbum(),
              SizedBox(height: 30),
              Text(
                'Reviews',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              ReviewSection(),
            ],
          ),
        ),
      ),
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
      ),
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
  final List<String> photos = [
    'assets/images/iqbal.jpeg',
    'assets/images/iqbal.jpeg',
    'assets/images/iqbal.jpeg',
  ];

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
            ),
          );
        },
      ),
    );
  }
}

class ReviewSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Write a review',
          ),
          maxLines: 5,
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            // Implement the logic to handle review submission
          },
          child: Text('Submit Review'),
        ),
      ],
    );
  }
}
