import 'package:flutter/material.dart';


class MyBookingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text('My bookings'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            BookingCard(
              type: 'TOUR PLAN',
              title: 'Tur Pulau Wayag Raja Ampat',
              date: '13 Mei 2023 - 15 Mei 2023 - 3 Days',
              status: 'PAID',
              statusColor: Colors.green,
              imageUrl: 'assets/images/iqbal.jpeg',
            ),
            BookingCard(
              type: 'STAYCATION',
              title: 'The Apurva Kempinski Bali',
              date: '20 June 2023 - 27 June 2023 - 6 Nights',
              status: 'NOT PAID',
              statusColor: Colors.red,
              imageUrl: 'assets/images/iqbal.jpeg',
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
              color: Colors.purple,
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
                  'Dolanku',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Image.asset(imageUrl, width: 50, height: 50, fit: BoxFit.cover),
            title: Text(title),
            subtitle: Text(date),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  status,
                  style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
