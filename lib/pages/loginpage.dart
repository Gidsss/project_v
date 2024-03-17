import 'package:flutter/material.dart';
import 'package:project_v/components/square_tile.dart';
import 'package:project_v/components/textfield.dart';
import 'package:project_v/components/button.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key, required String title});

  // This widget is the login page of the application.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //customer sign in method
  void userSignIn() {
    // sign-in logic to be added
  }

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

              // username textfield
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

              const SizedBox(height: 10),

              // forgot password?
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
              ),

              const SizedBox(height: 25),

              // sign in button
              Button(
                onTap: userSignIn,
              ),

              const SizedBox(height: 50),
              // or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
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
                    Expanded(
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
                  SquareTile(imagePath: 'assets/google.png'),

                  SizedBox(width: 25),

                  // facebook button
                  SquareTile(imagePath: 'assets/facebook.png')
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