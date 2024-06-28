import 'package:flutter/material.dart';

class UserMessageContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
                'https://example.com/jacob.jpg'), // Replace with the actual image URL
            radius: 25.0,
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jacob Mcleod',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  'And send me the proto...',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                '10m',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0,
                ),
              ),
              SizedBox(height: 5.0),
              Container(
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '3',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
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
