// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_application_1/homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  
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
        builder: (_) => const MyHomePage(
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
                Image.asset('assets/logo1.jpg'),
                const SizedBox(height: 16),   // Add some spacing
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black87),
                  strokeWidth: 3,
                  backgroundColor: Color.fromARGB(0, 57, 57, 57),
                ), // Loading indicator
              ],
            ),
          ),
        ),
      ),
    );
  }
}