import 'package:flutter/material.dart';

class AdminFeatureHeader extends StatelessWidget {
  const AdminFeatureHeader({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return adminfeatureHeader(text);
  }

  Widget adminfeatureHeader(String text) {
    return Container(
      width: double.infinity,
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          text,
          textAlign: TextAlign.center, // Title text
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 24.0, // Large text size
            fontWeight: FontWeight.bold, // Bold text
            color: Colors.white.withOpacity(0.95), // Dark color for the text
          ),
        ),
      ),
    );
  }
}
