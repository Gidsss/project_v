// Log-in Button in Log-in Page
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final Function()? onTap;

  const LoginButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 3),
                blurRadius: 3,
                spreadRadius: 7,
                color: Colors.grey.withOpacity(0.2))
          ],
          color: Colors.black,
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Center(
          child: Text(
            "LOGIN",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontFamily: 'Inter',
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
