import 'package:flutter/material.dart';

class CustomMenuBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomMenuBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF6F6F6).withOpacity(1),
            offset: const Offset(0, 1),
            blurRadius: 0,
            spreadRadius: -7,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMenuItem(
              'assets/icons/home-1.png', 'assets/icons/home-2.png', 'Home', 0),
          _buildMenuItem('assets/icons/orders-1.png',
              'assets/icons/orders-2.png', 'Orders', 1),
          _buildMenuItem('assets/icons/profile-1.png',
              'assets/icons/profile-2.png', 'Profile', 2),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String unselectedIconPath, String selectedIconPath,
      String label, int index) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: isSelected ? const EdgeInsets.all(12) : EdgeInsets.zero,
        decoration: isSelected
            ? BoxDecoration(
                color: const Color(0xFFFF73C3).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              )
            : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              isSelected ? selectedIconPath : unselectedIconPath,
              width: 24,
              height: 24,
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFFFF73C3),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
