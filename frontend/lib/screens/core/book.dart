import 'package:flutter/material.dart';
import 'package:frontend/screens/core/profile.dart';
import 'package:frontend/screens/home.dart';

class DoctorDetailPage extends StatefulWidget {
  final Profile profile;

  const DoctorDetailPage({required this.profile});

  @override
  _DoctorDetailPageState createState() => _DoctorDetailPageState();
}

class _DoctorDetailPageState extends State<DoctorDetailPage> {
  int selectedDateIndex = 2; // Default selected date index
  int selectedTimeIndex = 4;

  get profile => null; // Default selected time index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Booking Details",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontFamily: 'Outfit'),
        ),
        shadowColor: Colors.grey.withOpacity(0.5),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(widget.profile.imagePath),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.profile.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.profile.description,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Color(0xFFFF73C3), size: 20),
                        SizedBox(width: 4),
                        Text(
                          "4.7",
                          style: TextStyle(
                            color: Color(0xFFFF73C3),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              "About",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipi elit, sed do eiusmod tempor incididunt ut laore et dolore magna aliqua. Ut enim ad minim veniam...",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Day",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(7, (index) {
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDateIndex = index;
                          });
                        },
                        child: DateChip(
                          day: [
                            "Mon",
                            "Tue",
                            "Wed",
                            "Thu",
                            "Fri",
                            "Sat",
                            "Sun"
                          ][index],
                          date: (21 + index).toString(),
                          isSelected: selectedDateIndex == index,
                        ),
                      ),
                      if (index < 6)
                        SizedBox(
                            width:
                                10), // Menambahkan jarak antara elemen kecuali elemen terakhir
                    ],
                  );
                }),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Time",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(9, (index) {
                final times = [
                  "09:00 AM",
                  "10:00 AM",
                  "11:00 AM",
                  "01:00 PM",
                  "02:00 PM",
                  "03:00 PM",
                  "04:00 PM",
                  "07:00 PM",
                  "08:00 PM"
                ];
                final availability = [
                  false,
                  true,
                  false,
                  false,
                  true,
                  true,
                  true,
                  true,
                  false
                ];
                return GestureDetector(
                  onTap: availability[index]
                      ? () {
                          setState(() {
                            selectedTimeIndex = index;
                          });
                        }
                      : null, // Disable onTap if the time is not available
                  child: TimeChip(
                    time: times[index],
                    isAvailable: availability[index],
                    isSelected: selectedTimeIndex == index,
                  ),
                );
              }),
            ),
            SizedBox(height: 32),
          ],
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
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => DoctorDetailPage(profile: profile)),
                  // );
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
}

class DateChip extends StatelessWidget {
  final String day;
  final String date;
  final bool isSelected;

  const DateChip({
    Key? key,
    required this.day,
    required this.date,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFFFF73C3) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Color(0xFFFF73C3),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Column(
        children: [
          Text(
            day,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
              fontSize: 16,
            ),
          ),
          Text(
            date,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class TimeChip extends StatelessWidget {
  final String time;
  final bool isAvailable;
  final bool isSelected;

  const TimeChip({
    Key? key,
    required this.time,
    required this.isAvailable,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFFFF73C3) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
            color: isAvailable ? Color(0xFFFF73C3) : Colors.grey.shade300),
      ),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Text(
        time,
        style: TextStyle(
          color: isSelected
              ? Colors.white
              : isAvailable
                  ? Colors.black
                  : Colors.grey,
          fontSize: 16,
        ),
      ),
    );
  }
}
