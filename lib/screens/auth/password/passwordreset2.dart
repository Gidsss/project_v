// Forgot Password Screen Page 2
import 'package:flutter/material.dart';
import 'package:project_v/components/auth/changepasswordbutton.dart';
import 'package:project_v/components/auth/textfield.dart';
import 'package:project_v/screens/auth/password/forgotpasswordscreen.dart';
import 'package:project_v/constants/app_constants.dart';
// Forgot Password Screen
class PasswordReset2 extends StatelessWidget {
  PasswordReset2({super.key});

  final passwordController= TextEditingController();
  final confirmpasswordController= TextEditingController();


   void sendEmail(BuildContext context) {
    // send email logic to be added
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForgotPasswordScreen()), 
    );
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color.fromARGB(255, 249, 249, 249),
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
                icon: Image.asset(AppConstants.backIconPath),
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

              // welcome back, you've been missed!
              const Padding(
              padding: EdgeInsets.only(left: 25.0), // Adjust the padding as needed
              child: Text(
                'Enter your New Password.',
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
                controller: passwordController,
                hintText: 'Your New Password',
                obscureText: false,
                decoration: const InputDecoration(
                   border: OutlineInputBorder(),
                   labelText: 'Password',
                    
                ),
              ),
              const SizedBox(height: 10),
               MyTextField(
                controller: confirmpasswordController,
                hintText: 'Confirm Password',
                obscureText: false,
                decoration: const InputDecoration(
                   border: OutlineInputBorder(),
                   labelText: 'Confirm Password',
                    
                ),
              ),
              const SizedBox(height: 25),
              ChangePasswordButton(
                onTap: () {
                  sendEmail(context);
                }
              ),
        ],
      ),
    );
  }
  }
