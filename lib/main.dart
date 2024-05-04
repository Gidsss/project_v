import 'package:flutter/material.dart';
import 'package:project_v/routes.dart';
import 'package:project_v/screens/auth/log-in/splashscreen.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
    );

    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const fontFamily = 'Inter';

    // I commented this because it was resulting in every widget being white. Which was annoying.

    /*MaterialColor primaryColor = const MaterialColor(
      0xFFfdfdfd,
      <int, Color>{
        50: Color(0xFFfdfdfd),
        100: Color(0xFFfdfdfd),
        200: Color(0xFFfdfdfd),
        300: Color(0xFFfdfdfd),
        400: Color(0xFFfdfdfd),
        500: Color(0xFFfdfdfd),
        600: Color(0xFFfdfdfd),
        700: Color(0xFFfdfdfd),
        800: Color(0xFFfdfdfd),
        900: Color(0xFFfdfdfd),
      },
    );*/
    return MaterialApp(
      title: 'Valdopeña Opticals',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        // Set the scaffold background color to white
        scaffoldBackgroundColor: const Color.fromARGB(253, 253, 253, 253),

        // I commented this also because it was using the primarycolor variable defined in Line 18)
        // Set the color scheme with black as the primary color
        //colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryColor),

        // Use inter as the main font for the app.
        textTheme: const TextTheme(
            bodyLarge: TextStyle(fontFamily: fontFamily),
            bodySmall: TextStyle(fontFamily: fontFamily)),

        // Enable Material Design 3
        useMaterial3: true,
      ),
      home: const SplashScreen(), //Entry of the app
      routes: routes,
    );
  }
}
