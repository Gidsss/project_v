// Forgot Password Screen Page 1
import 'package:flutter/material.dart';
import 'package:project_v/constants/app_constants.dart';
import 'package:project_v/components/auth/resetpassbutton.dart';
import 'package:project_v/screens/auth/password/passwordreset2.dart';
// import 'package:project_v/components/auth/resetpassbutton.dart';
// import 'package:project_v/components/auth/textfield.dart';


class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  _PasswordResetState createState() => _PasswordResetState();
// ignore_for_file: library_private_types_in_public_api
   
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


             
              const SizedBox(
                height: 15,
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 249, 249, 249),
                  borderRadius: BorderRadius.circular(12),
                  
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _textFieldOTP(first: true, last: false),
                        _textFieldOTP(first: false, last: false),
                        _textFieldOTP(first: false, last: false),
                        _textFieldOTP(first: true, last: false),
                        _textFieldOTP(first: false, last: false),
                        _textFieldOTP(first: false, last: true),
                      ],
                    ),
                    
                    
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

Widget _textFieldOTP({required bool first, bool? last}) {
  return SizedBox(
    height: 65,
    width: 52,
    child: AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            width: 2, 
            color: Colors.black87, 
          ),
        ),
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          textAlignVertical: TextAlignVertical.center,
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12 , vertical: -2),
            counter: const Offstage(),
            border: InputBorder.none, 
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2, 
                color: Colors.black87, 
              ),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
    ),
  );
}
}