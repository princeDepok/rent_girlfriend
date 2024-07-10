import 'package:flutter/material.dart';

class MyBookingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Orders',
            style: TextStyle(
                color: Colors.black,
                fontFamily: "Outfit",
                fontWeight: FontWeight.w600),
          ),
          bottom: TabBar(
            labelColor: Color(0xFFFF73C3),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Color(0xFFFF73C3),
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'On Progress'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  BookingCard(
                    type: 'Paket Kondangan',
                    title: 'Iqbal Saputra',
                    date: '13 Mei 2024 - 14 Mei 2024 - 1 Day',
                    status: 'PENDING',
                    statusColor: Colors.orange,
                    imageUrl: 'assets/images/iqbal.jpeg',
                  ),
                  BookingCard(
                    type: 'SleepCall',
                    title: 'Ahmad Yusuf',
                    date: '20 June 2024 - 20 June 2024 - 3 Hours',
                    status: 'PENDING',
                    statusColor: Colors.orange,
                    imageUrl: 'assets/images/kennoy.jpeg',
                  ),
                  SizedBox(height: 20),
                  Text(
                    'You’ve reached at the end of your bookings, Order ',
                    style: TextStyle(fontSize: 16),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigate to more bookings page
                    },
                    child: Text(
                      'more bookings?',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  BookingCard(
                    type: 'Paket Kondangan',
                    title: 'Dina Amalia',
                    date: '15 Mei 2024 - 16 Mei 2024 - 1 Day',
                    status: 'ON PROGRESS',
                    statusColor: Colors.blue,
                    imageUrl: 'assets/images/dina.jpeg',
                  ),
                  BookingCard(
                    type: 'SleepCall',
                    title: 'Budi Santoso',
                    date: '22 June 2024 - 22 June 2024 - 3 Hours',
                    status: 'ON PROGRESS',
                    statusColor: Colors.blue,
                    imageUrl: 'assets/images/budi.jpeg',
                  ),
                  SizedBox(height: 20),
                  Text(
                    'You’ve reached at the end of your bookings, Order ',
                    style: TextStyle(fontSize: 16),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigate to more bookings page
                    },
                    child: Text(
                      'more bookings?',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  BookingCard(
                    type: 'Paket Kondangan',
                    title: 'Iqbal Saputra',
                    date: '13 Mei 2024 - 14 Mei 2024 - 1 Day',
                    status: 'DONE',
                    statusColor: Colors.green,
                    imageUrl: 'assets/images/iqbal.jpeg',
                  ),
                  BookingCard(
                    type: 'SleepCall',
                    title: 'Ahmad Yusuf',
                    date: '20 June 2024 - 20 June 2024 - 3 Hours',
                    status: 'DONE',
                    statusColor: Colors.green,
                    imageUrl: 'assets/images/kennoy.jpeg',
                  ),
                  SizedBox(height: 20),
                  Text(
                    'You’ve reached at the end of your bookings, Order ',
                    style: TextStyle(fontSize: 16),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigate to more bookings page
                    },
                    child: Text(
                      'more bookings?',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final String type;
  final String title;
  final String date;
  final String status;
  final Color statusColor;
  final String imageUrl;

  BookingCard({
    required this.type,
    required this.title,
    required this.date,
    required this.status,
    required this.statusColor,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFFFF73C3),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  type,
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Image.asset(
              imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error, color: Colors.red);
              },
            ),
            title: Text(title),
            subtitle: Text(date),
          ),
        ],
      ),
    );
  }
}
