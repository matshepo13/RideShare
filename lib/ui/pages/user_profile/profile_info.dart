import 'package:flutter/material.dart';
import 'package:lifts_app/ui/components/navbar.dart';
import 'package:lifts_app/ui/components/gradient_button.dart';


class ProfileInfoScreen extends StatefulWidget {
  @override
  _ProfileInfoScreenState createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  String _displayName = '';
  String _email = '';
  String _photoURL = ''; // Store the URL of the user's profile photo here

  Widget gradientIcon(IconData icon, List<Color> colors) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: colors,
        ).createShader(bounds);
      },
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }

  void _submitData() {
    // Validate and submit user data here
    // For simplicity, let's just print the data
    print('Display Name: $_displayName');
    print('Email: $_email');
    print('Photo URL: $_photoURL');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF15203C),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 3,
        onTap: (index) {
          // Placeholder for navigation logic
          print('Tapped index: $index');
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 38),
              GestureDetector(
                onTap: () {
                  // Implement image selection logic here
                },
                child: Container(
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
                    backgroundImage: _photoURL.isNotEmpty ? NetworkImage(_photoURL) : null,
                    // Use the user's selected image if available
                    child: _photoURL.isEmpty
                        ? const Icon(Icons.add_a_photo, color: Colors.white, size: 40)
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: (value) {
                  _displayName = value;
                },
                decoration: InputDecoration(
                  hintText: 'Display Name',
                  hintStyle: const TextStyle(color: Colors.white),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 8),
              TextField(
                onChanged: (value) {
                  _email = value;
                },
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: const TextStyle(color: Colors.white),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),
              GradientButton(
                text: 'Submit Data',
                onPressed: _submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


void main() {
  runApp(MaterialApp(
    home: ProfileInfoScreen(),
  ));
}
