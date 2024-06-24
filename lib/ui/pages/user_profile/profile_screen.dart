import 'package:flutter/material.dart';
import 'package:lifts_app/ui/components/navbar.dart'; // Import the CustomBottomNavBar widget
import 'package:lifts_app/ui/pages/user_profile/profile_info.dart'; // Import the ProfileInfoScreen
import 'package:lifts_app/ui/pages/offer_ride/created_lifts.dart'; // Import the CreatedLiftsPage

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState(); // Change this line
}

class _ProfileScreenState extends State<ProfileScreen> { // Change this class name
  int _currentIndex = 3; // Set the initial index to 3 (Profile)

  Widget gradientIcon(IconData icon, List<Color> colors) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: colors,
        ).createShader(bounds);
      },
      child: Icon(
        icon,
        color: Colors.white, // Set the icon's color to white
      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      // Navigation logic is handled in the CustomBottomNavBar
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF15203C), // Background color
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 38), // Move content down by 38 pixels
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF44B3DF), Colors.purple],
                  ),
                  border: Border.all(
                    color: Colors.transparent,
                    width: 3,
                  ),
                ),
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/woman.jpg'), // Use your image path
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Matshepo',
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'tebogomatshepo@gmail.com',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    _buildListTile(Icons.person, 'Personal Details', context),
                    const SizedBox(height: 16), // Add space between list tiles
                    _buildListTile(Icons.verified_user, 'Verification', context),

                    const SizedBox(height: 16), // Add space between list tiles
                    _buildListTile(Icons.directions_car, 'Offered Lift', context),
                    const SizedBox(height: 16), // Add space between list tiles
                    _buildListTile(Icons.emergency, 'Emergency Assistance', context),
                    const SizedBox(height: 16), // Add space between list tiles
                    _buildListTile(Icons.work, 'Professional Details', context),
                    const SizedBox(height: 16), // Add space between list tiles
                    _buildListTile(Icons.settings, 'Settings', context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, BuildContext context) {
    return ListTile(
      leading: GestureDetector(
        onTap: () {
          _navigateToPage(title, context);
        },
        child: gradientIcon(icon, [Color(0xFF44B3DF), Colors.purple]),
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      trailing: GestureDetector(
        onTap: () {
          _navigateToPage(title, context);
        },
        child: const Icon(Icons.edit, color: Colors.white),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      tileColor: const Color(0xFF1E2A47), // Tile background color
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  void _navigateToPage(String title, BuildContext context) {
    Widget page;
    switch (title) {
      case 'Offered Lift':
        page = CreatedLiftsPage(); // Navigate to CreatedLiftsPage
        break;
      default:
        page = ProfileInfoScreen(); // Default to ProfileInfoScreen for other tiles
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ProfileScreen(),
  ));
}
