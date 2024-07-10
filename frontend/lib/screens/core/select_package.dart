import 'package:flutter/material.dart';
import 'package:frontend/screens/auth/sign_up.dart';
import 'package:frontend/screens/core/order_summary.dart';
import 'package:frontend/services/token_storage.dart';
import 'package:intl/intl.dart';

class SelectPackages extends StatefulWidget {
  final Map<String, dynamic> companion;

  const SelectPackages({required this.companion});

  @override
  _SelectPackagesState createState() => _SelectPackagesState();
}

class _SelectPackagesState extends State<SelectPackages> {
  final TokenStorage _tokenStorage = TokenStorage();
  DateTime _selectedDate = DateTime.now();
  String? _selectedTime;
  int _selectedPriceIndex = -1; // Default selected price index
  int? _customDuration;
  final TextEditingController _customDurationController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final List<String> _times = [
    "05:00 AM",
    "06:00 AM",
    "07:00 AM",
    "08:00 AM",
    "09:00 AM",
    "10:00 AM",
    "11:00 AM",
    "12:00 PM",
    "01:00 PM",
    "02:00 PM",
    "03:00 PM",
    "04:00 PM",
    "05:00 PM",
    "06:00 PM",
    "07:00 PM",
    "08:00 PM",
    "09:00 PM",
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _handleBookNow() async {
    final userData = await _tokenStorage.getUserData();
    if (userData.isEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignUp()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderSummary(
            profileName: widget.companion['name'],
            imagePath: widget.companion['profile_picture'],
          ),
        ),
      );
    }
  }

  double _parsePrice(String price) {
    String cleanedPrice = price.replaceAll(RegExp(r'[^\d.]'), '');
    return double.parse(cleanedPrice);
  }

  Map<String, dynamic> _getPackage(int index) {
    final pricePerHour = _parsePrice(widget.companion['price_per_hour']);
    final NumberFormat currencyFormat = NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 2);

    switch (index) {
      case 0:
        final price = pricePerHour * 3;
        final discountedPrice = price - (price * 0.05);
        return {'label': '3 Jam', 'price': currencyFormat.format(discountedPrice)};
      case 1:
        final price = pricePerHour * 6;
        final discountedPrice = price - (price * 0.10);
        return {'label': '6 Jam', 'price': currencyFormat.format(discountedPrice)};
      case 2:
        final price = pricePerHour * 12;
        final discountedPrice = price - (price * 0.15);
        return {'label': '12 Jam', 'price': currencyFormat.format(discountedPrice)};
      default:
        return {'label': 'N/A', 'price': currencyFormat.format(0)};
    }
  }

  double _calculateCustomPrice(int duration) {
    final pricePerHour = _parsePrice(widget.companion['price_per_hour']);
    return pricePerHour * duration;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Select your package",
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
                  backgroundImage: NetworkImage(widget.companion['profile_picture']),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.companion['name'],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.companion['bio'],
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
                          widget.companion['rating'],
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
              widget.companion['bio'],
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
            InkWell(
              onTap: () => _selectDate(context),
              child: InputDecorator(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  contentPadding: EdgeInsets.all(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${_selectedDate.toLocal()}".split(' ')[0],
                      style: TextStyle(fontSize: 16),
                    ),
                    Icon(
                      Icons.calendar_today,
                      color: Colors.grey,
                    ),
                  ],
                ),
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
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                contentPadding: EdgeInsets.all(10.0),
              ),
              value: _selectedTime,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedTime = newValue;
                });
              },
              items: _times.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              "Price",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Column(
              children: List.generate(3, (index) {
                final package = _getPackage(index);
                return RadioListTile<int>(
                  title: Text('${package['label']} - ${package['price']}'),
                  value: index,
                  groupValue: _selectedPriceIndex,
                  onChanged: (int? value) {
                    setState(() {
                      _selectedPriceIndex = value!;
                      _customDurationController.clear();
                      _customDuration = null;
                    });
                  },
                );
              }),
            ),
            RadioListTile<int>(
              title: Row(
                children: [
                  Expanded(child: Text('Custom Duration')),
                  SizedBox(
                    width: 60,
                    child: TextField(
                      controller: _customDurationController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Hours',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _customDuration = int.tryParse(value);
                          _selectedPriceIndex = -1;
                        });
                      },
                    ),
                  ),
                ],
              ),
              value: 3,
              groupValue: _selectedPriceIndex,
              onChanged: (int? value) {
                setState(() {
                  _selectedPriceIndex = value!;
                });
              },
            ),
            if (_customDuration != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  'Total Price: Rp ${_calculateCustomPrice(_customDuration!).toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            SizedBox(height: 20),
            Text(
              "Phone Number",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                contentPadding: EdgeInsets.all(10.0),
                hintText: 'Enter your phone number',
              ),
            ),
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
                onPressed: _handleBookNow,
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
                    "Confirm Your Booking",
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
          color: isSelected ? Color(0xFFFF73C3) : Colors.grey,
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
