import 'package:flutter/material.dart';
import 'package:lifts_app/model/lift_model.dart';
import 'package:lifts_app/services/firestore_service.dart';
import 'package:lifts_app/ui/components/navbar.dart';
import 'package:lifts_app/ui/pages/find_ride/ride_detail_page.dart'; // Ensure this import is correct
import 'dart:async';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final FirestoreService _firestoreService = FirestoreService();
  List<Lift> _lifts = [];
  bool _isPopupVisible = false;
  bool _showDrivers = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _loadLifts();
  }

  Future<void> _loadLifts() async {
    List<Lift> lifts = await _firestoreService.getAvailableLifts();
    setState(() {
      _lifts = lifts;
    });
  }

  void _startDriverDisplayTimer() {
    setState(() {
      _showDrivers = false;
    });
    Timer(Duration(seconds: 10), () {
      setState(() {
        _showDrivers = true;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Lift Search',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF001F3F),
      ),
      body: Container(
        color: const Color(0xFF001F3F),
        child: Stack(
          children: [
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.lightBlue),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Where are you going?',
                            hintStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Icon(Icons.search, color: Colors.lightBlue),
                    onPressed: _startDriverDisplayTimer,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 150,
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    _buildAnimatedCircle(400),
                    _buildAnimatedCircle(320),
                    _buildAnimatedCircle(240),
                    _buildAnimatedCircle(160),
                    _buildAnimatedCircle(80),
                    // Display drivers' avatars
                    if (!_isPopupVisible && _showDrivers)
                      ..._lifts.map((lift) => _buildDriverAvatar(lift)).toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 0,
        onTap: _onNavBarTapped,
      ),
    );
  }

  Widget _buildDriverAvatar(Lift lift) {
    return Positioned(
      top: 140,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isPopupVisible = true;
          });
          showRideDetailDialog(context, lift, () {
            setState(() {
              _isPopupVisible = false;
            });
          });
        },
        child: CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('assets/driver.jpg'), // Use the driver's image
        ),
      ),
    );
  }

  Widget _buildAnimatedCircle(double diameter) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: 1 + 0.1 * (_controller.value - 0.5),
          child: child,
        );
      },
      child: SizedBox(
        width: diameter,
        height: diameter,
        child: CustomPaint(
          painter: const GradientCirclePainter(),
        ),
      ),
    );
  }

  void _onNavBarTapped(int index) {}
}

class GradientCirclePainter extends CustomPainter {
  const GradientCirclePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    const Gradient gradient = SweepGradient(
      colors: [Color(0xFF44B3DF), Colors.purple, Colors.black],
      stops: [0.0, 0.5, 1.0],
    );
    final Paint paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
