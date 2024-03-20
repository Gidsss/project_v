import 'package:flutter/material.dart';
import 'package:project_v/components/sendbutton.dart';
import 'package:project_v/components/textfield.dart';
// Forgot Password Screen
class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final emailController = TextEditingController();

   void sendEmail() {
    // send email logic to be added
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align content to the upper-left corner
        children: [
          const SizedBox(height: 50),
          // Custom icon with smaller size
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: SizedBox(
              width: 40, // Adjust width as needed
              height: 40, // Adjust height as needed
              child: IconButton(
                iconSize: 24, // Adjust icon size as needed
                icon: Image.asset('assets/previous.png'), // Replace 'assets/previous.png' with the path to your custom icon
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          // Logo
          const SizedBox(height: 50),
          const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Forgot Password',
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

              // welcome back, you've been missed!
              const Padding(
              padding: EdgeInsets.only(left: 20.0), // Adjust the padding as needed
              child: Text(
                'We’ll send you a code to reset your password.',
                style: TextStyle(
                  color: Color(0xFF757575),
                  fontSize: 11,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
             const SizedBox(height: 25),

              // email textfield
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
                decoration: const InputDecoration(
                   border: OutlineInputBorder(),
                   labelText: 'Email',
                    
                ),
              ),
              const SizedBox(height: 25),
              SendButton(
                onTap: sendEmail,
              ),
        ],
      ),
    );
  }
  }
