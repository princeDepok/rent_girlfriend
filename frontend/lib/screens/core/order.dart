import 'package:flutter/material.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/services/token_storage.dart';

class MyBookingsPage extends StatefulWidget {
  @override
  _MyBookingsPageState createState() => _MyBookingsPageState();
}

class _MyBookingsPageState extends State<MyBookingsPage> {
  final ApiService _apiService = ApiService();
  final TokenStorage _tokenStorage = TokenStorage();
  List<dynamic> _pendingBookings = [];
  List<dynamic> _onProgressBookings = [];
  List<dynamic> _completedBookings = [];

  @override
  void initState() {
    super.initState();
    _fetchBookings();
  }

  Future<void> _fetchBookings() async {
    final accessToken = await _tokenStorage.getAccessToken();
    if (accessToken != null) {
      final bookings = await _apiService.getUserBookings(accessToken);
      if (bookings != null) {
        setState(() {
          _pendingBookings = bookings.where((booking) => booking['status'] == 'pending').toList();
          _onProgressBookings = bookings.where((booking) => booking['status'] == 'on_progress').toList();
          _completedBookings = bookings.where((booking) => booking['status'] == 'completed').toList();
        });
      }
    }
  }

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
            _buildBookingList(_pendingBookings),
            _buildBookingList(_onProgressBookings),
            _buildBookingList(_completedBookings),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingList(List<dynamic> bookings) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return BookingCard(
                  type: booking['type'] ?? 'N/A',
                  title: booking['companion_name'] ?? 'N/A',
                  date: '${booking['tanggal']} - ${booking['waktu']}',
                  status: booking['status'].toUpperCase(),
                  statusColor: _getStatusColor(booking['status']),
                  imageUrl: booking['companion_image'] ?? 'assets/images/default.jpg',
                );
              },
            ),
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
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'on_progress':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      default:
        return Colors.grey;
    }
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
                  status,
                  style: TextStyle(color: statusColor),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Image.network(
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
