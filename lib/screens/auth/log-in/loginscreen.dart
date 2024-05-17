import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_v/widgets/img/square_tile.dart';
import 'package:project_v/widgets/textfields/textfield.dart';
import 'package:project_v/widgets/buttons/auth/loginbutton.dart';
import 'package:project_v/screens/auth/password/forgotpasswordscreen.dart';
import 'package:project_v/screens/auth/signup/signupscreen.dart';
import 'package:project_v/constants/app_constants.dart';
import 'package:project_v/screens/customer/homescreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:project_v/screens/admin/admindashboard.dart';

Future<void> signInWithGoogle(BuildContext context) async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/userinfo.email',
        'https://www.googleapis.com/auth/userinfo.profile',
      ],
    ).signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    final User? user = userCredential.user;

    if (user != null) {
      String? imageUrl;
      if (googleUser?.photoUrl != null) {
        try {
          // Download the image
          final response = await http.get(Uri.parse(googleUser!.photoUrl!));
          final Directory tempDir = Directory.systemTemp;
          final File file = File('${tempDir.path}/profile.jpg');
          await file.writeAsBytes(response.bodyBytes);

          // Upload to Firebase Storage
          TaskSnapshot uploadTask = await FirebaseStorage.instance
              .ref('profilePics/${user.uid}')
              .putFile(file);
          imageUrl = await uploadTask.ref.getDownloadURL();
        } catch (e) {
          print('Error uploading profile picture: $e');
        }
      }

      await FirebaseFirestore.instance.collection('customers').doc(user.uid).set({
        'UID': user.uid,
        'name': googleUser?.displayName ?? '',
        'email': googleUser?.email ?? '',
        'profilePic': imageUrl ?? '',
      });

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  } catch (error) {
    print('Google sign-in error: $error');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Google sign-in failed: $error')),
    );
  }
}

Future<void> signInWithFacebook(BuildContext context) async {
  try {
    final LoginResult fbLoginResult = await FacebookAuth.instance.login();

    if (fbLoginResult.status == LoginStatus.success) {
      final AccessToken? _fbaccessToken = fbLoginResult.accessToken;
      final userData = await FacebookAuth.instance.getUserData(fields: "name,email,picture.width(200)");
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(_fbaccessToken!.token);

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      final User? user = userCredential.user;

      if (user != null) {
        String? imageUrl;
        if (userData['picture']['data']['url'] != null) {
          try {
            // Download the image
            final response = await http.get(Uri.parse(userData['picture']['data']['url']));
            final Directory tempDir = Directory.systemTemp;
            final File file = File('${tempDir.path}/profile.jpg');
            await file.writeAsBytes(response.bodyBytes);

            // Upload to Firebase Storage
            TaskSnapshot uploadTask = await FirebaseStorage.instance
                .ref('profilePics/${user.uid}')
                .putFile(file);
            imageUrl = await uploadTask.ref.getDownloadURL();
          } catch (e) {
            print('Error uploading profile picture: $e');
          }
        }

        await FirebaseFirestore.instance.collection('customers').doc(user.uid).set({
          'UID': user.uid,
          'name': userData['name'] ?? '',
          'email': userData['email'] ?? '',
          'profilePic': imageUrl ?? '',
        });

        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Facebook sign-in failed: ${fbLoginResult.message}')),
        );
      }
      print("Fail FB Login Status: ${fbLoginResult.status}");
      print("Fail FB Login Message: ${fbLoginResult.message}");
    }
  } catch (e) {
    print("FB Login Error: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Facebook sign-in failed: $e')),
    );
  }
}


class LoginScreen extends StatelessWidget {
  LoginScreen({super.key, required this.title});
  static String routeName = "/login";
  final String title;

  // Text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login(BuildContext context) async {
    try {
      // Attempt to sign in the user
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());

      // Check if the email is that of the admin and redirect accordingly
      if (userCredential.user!.email == "valdopenacse@gmail.com") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminDashboardScreen()),
        );
        print("Admin login successful: ${userCredential.user!.email}");
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        print("Login successful: ${userCredential.user!.email}");
      }
    } catch (e) {
      // If there is an error, display a message to the user
      print("Login failed: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login failed: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 249, 249),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),

                // Logo
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
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

                // Welcome back, you've been missed!
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
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

                // Email textfield
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

                // Password textfield
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

                // Forgot password? and don't have an account
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ForgotPasswordScreen()));
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()));
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

                // Sign in button
                LoginButton(
                  onTap: () => login(context),
                ),
                const SizedBox(height: 50),

                // Or login using
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
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
                      width: 20,
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Google + Facebook sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Google button
                    SquareTile(
                      imagePath: AppConstants.googleIconPath,
                      onTap: () async {
                        await signInWithGoogle(context);
                      },
                    ),
                    const SizedBox(width: 25),
                    // Facebook button
                    SquareTile(
                      imagePath: AppConstants.facebookIconPath,
                      onTap: () async {
                        await signInWithFacebook(context);
                      },
                    ),
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
