import 'package:flutter/material.dart';

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
