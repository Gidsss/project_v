import 'package:flutter/material.dart';
import 'package:project_v/widgets/img/square_tile.dart';
import 'package:project_v/widgets/textfields/textfield.dart';
import 'package:project_v/widgets/buttons/auth/loginbutton.dart';
import 'package:project_v/screens/auth/password/forgotpasswordscreen.dart';
import 'package:project_v/screens/auth/signup/signupscreen.dart';
import 'package:project_v/constants/app_constants.dart';
import 'package:project_v/screens/main/homescreen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key, required String title});
  static String routeName = "/login";
  // This widget is the login page of the application.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 249, 249),
      body: SafeArea(
        child: SingleChildScrollView( //fixed bottom overflowing
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),

              // logo
              const Padding(
              padding: EdgeInsets.only(left: 20.0), // Adjust the padding as needed
              child: Text(
                'Login',
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
                'Welcome back.',
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

              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                   labelText: 'Password',
                   
                ),
              
              ),

              const SizedBox(height: 20),

              // forgot password? and don't have an acct
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Go to the Forgot Password screen
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Go to the Sign Up screen
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                    },
                    child: Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
            ),

              const SizedBox(height: 25),

              // sign in button
              LoginButton(
                onTap: (){
                  // Sign-in, go to Home Screen
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomeScreen()));
                }
              ),

              const SizedBox(height: 50),
              // or login using
               Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20, // Adjust width as needed
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Or Login Using',
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Inter',
                        fontSize: 14,
                        
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20, // Adjust width as needed
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),

              const SizedBox(height: 20),

              // google + facebook sign in buttons
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // google button
                  SquareTile(imagePath: AppConstants.googleIconPath),
                  SizedBox(width: 25),
                  // facebook button
                  SquareTile(imagePath: AppConstants.facebookIconPath)
                ],
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    ),
    );
  }
}