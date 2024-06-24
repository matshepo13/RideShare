import 'package:flutter/material.dart';
import 'dart:ui'; // Import for ImageFilter
import 'package:lifts_app/ui/pages/offer_ride/offer_ride_page.dart'; // Import the RideSharePage
import 'package:lifts_app/ui/pages/user_profile/profile_screen.dart'; // Import the ProfileScreen
import 'package:lifts_app/ui/pages/notifications/notification.dart'; // Import the NotificationPage
import 'package:lifts_app/ui/pages/introduction/welcome_page.dart'; // Import the WelcomePage

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(0)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          color: const Color(0xFF001F3F), // Dark blue background color for nav bar
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildGradientIcon(Icons.home, currentIndex == 0, () {
                // Navigate to WelcomePage when home icon button is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomePage()),
                );
              }),
              _buildGradientIcon(Icons.directions_car, currentIndex == 1, () {
                // Navigate to RideSharePage when direction car icon button is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RideShare()),
                );
              }),
              _buildGradientIcon(Icons.chat, currentIndex == 2, () {
                // Navigate to NotificationPage when chat icon button is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationPage()), // Remove notifications parameter
                );
              }),
              _buildGradientIcon(Icons.person, currentIndex == 3, () {
                // Navigate to ProfileScreen when person icon button is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGradientIcon(IconData icon, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            colors: isSelected ? [Colors.blue, Colors.purple] : [Colors.blue, Colors.purple], // Use blue and purple gradient when selected or not
          ).createShader(bounds);
        },
        child: Icon(
          icon,
          color: isSelected ? null : Colors.white, // Set the icon's color to white when not selected
        ),
      ),
    );
  }
}
