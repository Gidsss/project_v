// Google and Facebook Icons in Log-in Page
import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  final Function () onTap;
  const SquareTile({
    super.key,
    required this.imagePath,
    this.onTap, // Accept onTap as a parameter, making it nullable to allow for tiles without interaction
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // Use InkWell to provide visual feedback on tap
      onTap: onTap, // Pass the onTap callback
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // Set opacity to 20%
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Image.asset(
          imagePath,
          height: 40,
        ),
      ),
    );
  }
}