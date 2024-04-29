import 'package:flutter/widgets.dart';
import 'package:project_v/screens/auth/log-in/splashscreen.dart';
import 'package:project_v/screens/auth/log-in/loginscreen.dart';

// We use name routes, import every screen for the route
// All our routes will be available here
// Do this in polishing stage.
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  LoginScreen.routeName: (context) => LoginScreen(title: 'Valdopeña Opticals',),

 
};