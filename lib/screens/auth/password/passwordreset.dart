import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project_v/constants/app_constants.dart';
import '../log-in/loginscreen.dart';

class PasswordReset extends StatefulWidget {
  final String userEmail;

  const PasswordReset({required this.userEmail, Key? key}) : super(key: key);

  @override
  _PasswordResetState createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  DateTime? expirationTime;
  late Timer _timer;
  int remainingSeconds = 300; // 5 minutes in seconds

  @override
  void initState() {
    super.initState();
    expirationTime = DateTime.now().add(Duration(seconds: remainingSeconds));
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (remainingSeconds > 0) {
          remainingSeconds--;
          expirationTime = DateTime.now().add(Duration(seconds: remainingSeconds));
        } else {
          timer.cancel(); // Stop the timer when expiration time is reached
        }
      });
    });
  }

  void resendResetEmail() {
    // Add logic to resend the reset email here
    // You can also update the expiration time if needed
    setState(() {
      remainingSeconds = 300; // Reset remaining seconds
      expirationTime = DateTime.now().add(Duration(seconds: remainingSeconds));
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 249, 249, 249),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: IconButton(
                    iconSize: 24,
                    icon: Image.asset(AppConstants.backIconPath),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              const SizedBox(height: 50),
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Reset Password',
                  style: TextStyle(
                    color: Color(0xFF222222),
                    fontSize: 34,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w900,
                    height: 1,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, bottom: 16.0),
                child: Text(
                  "for " + widget.userEmail,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 83.0),
                child: Column(
                  children: [
                    // Show success message and expiration time
                    Text(
                      'Reset link sent successfully!',
                      style: TextStyle(color: Colors.green, fontSize: 32),
                    ),
                    const SizedBox(height: 15),
                    if (remainingSeconds > 0)
                      Text(
                        'Link expires in (${remainingSeconds ~/ 60} minutes ${remainingSeconds % 60} seconds)',
                        style: TextStyle(color: Colors.black87),
                      ),
                    const SizedBox(height: 55),
                    // Button to navigate to login screen
                    ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                        fixedSize: MaterialStateProperty.all<Size>(const Size(200, 35)),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen(title: 'Valdopeña Opticals')),
                        );
                      },
                      child: Text('Back to Login'),
                    ),
                    const SizedBox(height: 10), // Added SizedBox for spacing
                    // Button to resend reset email
                    InkWell(
                      onTap: resendResetEmail,
                      child: Text(
                        'Resend Email',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
