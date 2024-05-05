import 'package:flutter/material.dart';
import 'package:project_v/widgets/img/square_tile.dart';
import 'package:project_v/widgets/textfields/textfield.dart';
import 'package:project_v/widgets/buttons/auth/loginbutton.dart';
import 'package:project_v/screens/auth/password/forgotpasswordscreen.dart';
import 'package:project_v/screens/auth/signup/signupscreen.dart';
import 'package:project_v/constants/app_constants.dart';
import 'package:project_v/screens/customer/homescreen.dart';
import 'package:project_v/screens/admin/admindashboard.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key, required String title});
  static String routeName = "/login";

  @override
  State<LoginScreen> createState() => LoginScreenState();
}
// This widget is the login page of the application.

// This class is the configuration for the state. It holds the values (in this
// case the title) provided by the parent (in this case the App widget) and
// used by the build method of the State. Fields in a Widget subclass are
// always marked "final".

class LoginScreenState extends State<LoginScreen> {
  Map<String, dynamic>? _userData; // used to store user data.
  AccessToken? _fbaccessToken;

  // FB LOGIN
  Future<void> _login(BuildContext context) async {
    try {
      final LoginResult fbresult = await FacebookAuth.instance.login();

      if (fbresult.status == LoginStatus.success) {
        _fbaccessToken = fbresult.accessToken;
        final userData = await FacebookAuth.instance.getUserData();
        _userData = userData;

        if (context.mounted) {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => const HomeScreen())));
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100)),
                  height: 185, // Set the desired height
                  width: MediaQuery.of(context).size.width *
                      0.67, // Set the desired width
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Login Unsuccessful",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "Facebook Login Failed. Please try again or use other login methods.",
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: ElevatedButton(
                                  style: const ButtonStyle(
                                      elevation: MaterialStatePropertyAll(4),
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.black)),
                                  onPressed: () {
                                    Navigator.pop(
                                      context,
                                    );
                                  },
                                  child: const Text(
                                    "Okay",
                                    style: TextStyle(color: Colors.white),
                                  ))),
                        )
                      ],
                    ),
                  )),
            );
          },
        );
        print("Fail FB Login Status: ${fbresult.status}");
        print("Fail FB Login Message: ${fbresult.message}");
      }
    } catch (e) {
      print("FB Login Error: $e");
    }
  }

  // FB LOGOUT
  Future<void> _logOut() async {
    await FacebookAuth.instance.logOut();
    _fbaccessToken = null;
    _userData = null;
    setState(() {});
  }

  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
                LoginButton(onTap: () {
                  // Sign-in, go to Home Screen of Customer or Admin, will add a check for the user type later
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomeScreen()));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AdminDashboardScreen()));
                }),

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
                      onTap: () {},
                    ),
                    const SizedBox(width: 25),
                    // facebook button
                    SquareTile(
                        imagePath: AppConstants.facebookIconPath,
                        onTap: () {
                          _userData == null ? _login(context) : _logOut();
                        }),
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