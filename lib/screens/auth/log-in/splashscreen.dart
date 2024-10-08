// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:project_v/screens/auth/log-in/loginscreen.dart';
import 'package:project_v/constants/app_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static String routeName = "/splash";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }
  
  _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {});
    _navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(
        builder: (_) => LoginScreen(
          title: 'Valdopeña Opticals',
        ),
      ),
    );
  }


   @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      onGenerateRoute: (_) => MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppConstants.logoImagePath,
                  width: 350, 
                  height: 350, 
                  fit: BoxFit.contain, 
                ),
                const SizedBox(height: 45),   // Add some spacing
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black54),
                  strokeWidth: 3,
      
                ), // Loading indicator
              ],
            ),
          ),
        ),
      ),
    );
  }
}