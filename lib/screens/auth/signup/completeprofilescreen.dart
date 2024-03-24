import 'package:flutter/material.dart';
import 'package:project_v/widgets/buttons/auth/donebutton.dart';
import 'package:project_v/widgets/img/profilepic.dart';
import 'package:project_v/widgets/textfields/textfield.dart';
import 'package:project_v/screens/auth/log-in/loginscreen.dart';


class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  static String routeName = "/profile";

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phonenumController = TextEditingController();
  final addressController = TextEditingController();

  void completeSignUp(BuildContext context) {
      // Sign up logic to be added

      // Navigate to the next screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen(title: 'Valdopeña Opticals',)), // Replace NextScreen with the screen you want to navigate to
      );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: SizedBox(
              width: 40,
              height: 40,
              child: IconButton(
                iconSize: 24,
                icon: Image.asset('assets/previous.png'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.only(left: 35.0),
            child: Text(
              'Complete Your Profile',
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
          const Padding(
            padding: EdgeInsets.only(left: 125.0),
            child: Text(
              "Tell us a little bit about yourself.",
              style: TextStyle(
                color: Color(0xFF757575),
                fontSize: 11,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 155.0),
            child: ProfilePic(),
          ),
            const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: MyTextField(
              controller: nameController,
              hintText: 'Name',
              obscureText: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: MyTextField(
              controller: emailController,
              hintText: 'Email',
              obscureText: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: MyTextField(
              controller: phonenumController,
              hintText: 'Phone Number',
              obscureText: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Phone Number',
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: MyTextField(
              controller: addressController,
              hintText: 'Address',
              obscureText: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Address',
              ),
            ),
          ),
          const SizedBox(height: 25),
              DoneButton(
                onTap: () {
                  completeSignUp(context);
                }
              ),
          ],
        ),
      ),
    );
  }
}