import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    // Optionally push to the HomeScreen or handle the authenticated user.
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));
  } catch (error) {
    print('Google sign-in error: $error');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Google sign-in failed: $error')),
    );
  }
}

// FB LOGIN
Future<void> signInWithFacebook(BuildContext context) async {
  Map<String, dynamic>? _userData; // used to store user data.
  AccessToken? _fbaccessToken;
  try {
    final LoginResult fbLoginResult = await FacebookAuth.instance.login();

    if (fbLoginResult.status == LoginStatus.success) {
      _fbaccessToken = fbLoginResult.accessToken;

      final userData = await FacebookAuth.instance.getUserData();
      _userData = userData;

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(fbLoginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

      if (context.mounted) {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const HomeScreen())));
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text('Facebook sign-in failed: ${fbLoginResult.message}')));
      }
      print("Fail FB Login Status: ${fbLoginResult.status}");
      print("Fail FB Login Message: ${fbLoginResult.message}");
    }
  } catch (e) {
    print("FB Login Error: $e");
  }
}

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

  void login(BuildContext context) async {
    try {
      // Attempt to sign in the user.
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());

      // Check if the email is that of the admin and redirect accordingly.
      if (userCredential.user!.email == "gideonsalangsang0428@gmail.com" || userCredential.user!.email == "j.d.mingming13@gmail.com") // supposedly valdopeñamerchant
      {
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
      // If there is an error, display a message to the user.
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
          //fixed bottom overflowing
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),

                // logo
                const Padding(
                  padding: EdgeInsets.only(
                      left: 20.0), // Adjust the padding as needed
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
                  padding: EdgeInsets.only(
                      left: 20.0), // Adjust the padding as needed
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
                          // Go to the Sign Up screen
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

                // sign in button
                LoginButton(
                  onTap: () => login(context),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    SquareTile(
                      imagePath: AppConstants.googleIconPath,
                      onTap: () async {
                        await signInWithGoogle(context);
                      },
                    ),
                    const SizedBox(width: 25),
                    // facebook button
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
