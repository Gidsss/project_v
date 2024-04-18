import 'package:flutter/material.dart';
import 'package:project_v/widgets/buttons/auth/continueasguestbutton.dart';
import 'package:project_v/widgets/buttons/auth/signupbutton.dart';
import 'package:project_v/screens/auth/signup/completeprofilescreen.dart';
import 'package:project_v/widgets/textfields/textfield.dart';
import 'package:project_v/screens/auth/log-in/loginscreen.dart';
import 'package:project_v/constants/app_constants.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

   void signUp(BuildContext context) {
    // Sign up logic to be added

    // Navigate to the next screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileScreen()), // Replace NextScreen with the screen you want to navigate to
    );
  }

  void continueasGuest(BuildContext context) {
    // Sign up logic to be added

    // Navigate to the next screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen(title: 'Valdopeña Opticals',)), // Replace NextScreen with the screen you want to navigate to
    );
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
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
              'Sign Up',
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
          const Padding(
            padding: EdgeInsets.only(left: 23.0),
            child: Text(
              "Start the journey you've always envisioned.",
              style: TextStyle(
                color: Color(0xFF757575),
                fontSize: 11,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: MyTextField(
              controller: emailController,
              hintText: 'Email',
              obscureText: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: MyTextField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: MyTextField(
              controller: confirmPasswordController,
              hintText: 'Confirm Password',
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Confirm Password',
              ),
            ),
          ),
          const SizedBox(height: 30),
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 200.0), // Adjust left padding as needed
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(title: 'Valdopeña Opticals')));
                },
                child: Text(
                  'Already have an account?',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
              SignUpButton(
                onTap: () {
                  signUp(context);
                }
              ),
        const SizedBox(height: 25),
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 165.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 10, // Adjust width as needed
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Or',
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Inter',
                        fontSize: 14,
                        
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10, // Adjust width as needed
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
              GuestButton(
                onTap: () {
                  continueasGuest(context); //edit this
                }
              ),
        ],
      ),
    ),
  );
}
}