import 'package:flutter/material.dart';
import 'package:frontend/screens/core/select_package.dart';

class CompanionDetails extends StatefulWidget {
  final Map<String, dynamic> companion;

  const CompanionDetails({required this.companion});

  @override
  State<CompanionDetails> createState() => _CompanionDetailsState();
}

class _CompanionDetailsState extends State<CompanionDetails> {
  late String _backgroundImage;

  @override
  void initState() {
    super.initState();
    _backgroundImage = widget.companion['profile_picture'];
  }

  void _updateBackgroundImage(String newImage) {
    setState(() {
      _backgroundImage = newImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> photos = [widget.companion['profile_picture']];
    if (widget.companion['photos'] != null) {
      for (var photo in widget.companion['photos']) {
        photos.add(photo['photo']);
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              _backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.2,
            maxChildSize: 0.8,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          widget.companion['name'] ?? 'Unknown',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Outfit',
                            shadows: [
                              Shadow(
                                offset: const Offset(0, 2),
                                blurRadius: 3.0,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                              decoration: BoxDecoration(
                                color: widget.companion['gender'] == 'Male'
                                    ? const Color.fromARGB(255, 110, 227, 240)
                                    : const Color.fromARGB(255, 248, 157, 188),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    widget.companion['gender'] == 'Male' ? Icons.male : Icons.female,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    widget.companion['gender'] ?? 'N/A',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 15),
                            Row(
                              children: [
                                const Icon(Icons.star_border_outlined, size: 20, color: Colors.yellow),
                                const SizedBox(width: 4),
                                Text(
                                  '${widget.companion['rating'] ?? 'N/A'}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          'About',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Outfit',
                          ),
                        ),
                        Text(
                          widget.companion['bio'] ?? 'No biography available.',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          'Photo Album',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Outfit',
                          ),
                        ),
                        const SizedBox(height: 10),
                        PhotoAlbum(
                          photos: photos,
                          onPhotoTap: _updateBackgroundImage,
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SelectPackages(companion: widget.companion)),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF73C3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              shadowColor: Colors.grey.withOpacity(0.5),
                              elevation: 5,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 50.0,
                                vertical: 15.0,
                              ),
                              child: Text(
                                "Select Package",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                  fontFamily: 'Outfit',
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: 5,
            left: 16,
            child: SafeArea(
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PhotoAlbum extends StatelessWidget {
  final List<String> photos;
  final Function(String) onPhotoTap;

  const PhotoAlbum({required this.photos, required this.onPhotoTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: photos.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onPhotoTap(photos[index]),
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              width: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(photos[index]),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
