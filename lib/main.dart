import 'package:flutter/material.dart';
import 'package:project_v/pages/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     MaterialColor primaryColor = const MaterialColor(
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
    );
    return MaterialApp(
      title: 'Valdopeña Opticals',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
         // Set the scaffold background color to white
        scaffoldBackgroundColor: const Color.fromARGB(253, 253, 253, 253),
        // Set the color scheme with black as the primary color
        colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryColor),
        // Enable Material Design 3
        useMaterial3: true,
      ),
      home: const SplashScreen(), //Entry of the app
    );
  }
}
