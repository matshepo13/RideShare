// exercise/lib/ui/components/white_back_button.dart
import 'package:flutter/material.dart';

class WhiteBackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const WhiteBackButton({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.white),
      onPressed: onPressed,
    );
  }
}
