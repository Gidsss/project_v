// Forgot Password Screen Page 1
import 'package:flutter/material.dart';
import 'package:project_v/constants/app_constants.dart';
import 'package:project_v/widgets/buttons/auth/resetpassbutton.dart';
import 'package:project_v/screens/auth/password/passwordreset2.dart';
import 'package:project_v/widgets/textfields/otptextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';



class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  _PasswordResetState createState() => _PasswordResetState();
// ignore_for_file: library_private_types_in_public_api
   
}

Future<void> sendPasswordResetEmail(String email) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    print('Password reset email sent successfully');
  } catch (e) {
    print('Error sending password reset email: $e');
    // Handle the error appropriately, such as displaying a snackbar or an error message to the user
  }
}


void sendOTP(BuildContext context) {
    // send email logic to be added
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PasswordReset2()), 
    );
  }
  
class _PasswordResetState extends State<PasswordReset> {

    final String userEmail = 'gids****@gmail.com'; // Replace with actual email 


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
          // Custom icon with smaller size
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: SizedBox(
              width: 40, // Adjust width as needed
              height: 40, // Adjust height as needed
              child: IconButton(
                iconSize: 24, // Adjust icon size as needed
                icon: Image.asset(AppConstants.backIconPath), // Replace 'assets/previous.png' with the path to your custom icon
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),

          //Reset Password
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

              // Text
              const Padding(
              padding: EdgeInsets.only(left: 25.0), // Adjust the padding as needed
              child: Text(
                "Enter the 6 digit code that we've sent to your email:",
                style: TextStyle(
                  color: Color(0xFF757575),
                  fontSize: 11,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),

            // Placeholder for user's email
            Padding(
              padding: const EdgeInsets.only(left: 25.0, bottom: 16.0),
              child: Text(
                userEmail, // Display the user's email
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),


             const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 249, 249, 249),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Use OTPTextField widget for each OTP field
                  for (int i = 0; i < 6; i++)
                    OTPTextField(first: i == 0, last: i == 5),
                ],
              ),
            ),
              ResetButton(
                    onTap: () {
                      sendOTP(context);
                    }
                  ),
              
              const SizedBox(
                      height: 12,
                    ),

              // forgot password? and don't have an acct
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 83.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                      "Didn't receive an email?",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                   const Text(
                      "RESEND (45s)",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
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