import 'package:flutter/material.dart';
import 'package:project_v/constants/app_constants.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/customerfooter.dart';
import 'package:project_v/screens/customer/chat/chatscreen.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/header2.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header2(text: "Contact Us"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    //Facebook Page
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Facebook Page",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 5,),

                    //Facebook Page Button
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3), // Adjusted shadow color and opacity
                              spreadRadius: 1, // Reduced spread radius
                              blurRadius: 10, // Reduced blur radius
                              offset: Offset(0, 2), // Offset in the x and y direction
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            // Add button functionality here
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white), // Button background color
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0), // Button border radius
                              ),
                            ),
                            elevation: MaterialStateProperty.all(0), // Set button elevation to 0
                            overlayColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors.grey; // Change color on pressed
                                }
                                return Colors.white; // Set default overlay color
                              },
                            ),
                            minimumSize: MaterialStateProperty.all(const Size(800, 40)), // Adjust the width and height
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: Image.asset(
                                  'assets/images/FBIcon.png', // asset icon
                                  width: 26,
                                  height: 26,
                                ),
                              ),
                              SizedBox(width: 10,),
                              const Text(
                                'valdopenaopticalshop',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: "Inter",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    //Gmail
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Gmail",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 5,),

                    //Gmail Button
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3), // Adjusted shadow color and opacity
                              spreadRadius: 1, // Reduced spread radius
                              blurRadius: 10, // Reduced blur radius
                              offset: Offset(0, 2), // Offset in the x and y direction
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            // Add button functionality here
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white), // Button background color
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0), // Button border radius
                              ),
                            ),
                            elevation: MaterialStateProperty.all(0), // Set button elevation to 0
                            overlayColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors.grey; // Change color on pressed
                                }
                                return Colors.white; // Set default overlay color
                              },
                            ),
                            minimumSize: MaterialStateProperty.all(const Size(800, 40)), // Adjust the width and height
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: Image.asset(
                                  'assets/images/GmailIcon.png', // asset icon
                                  width: 26,
                                  height: 26,
                                ),
                              ),
                              SizedBox(width: 10,),
                              const Text(
                                'valdopenaopticalshop@gmail.com',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: "Inter",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    //Phone/Telephone
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Phone/Telephone",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 5,),

                    //Phone/Telephone Button
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3), // Adjusted shadow color and opacity
                              spreadRadius: 1, // Reduced spread radius
                              blurRadius: 10, // Reduced blur radius
                              offset: Offset(0, 2), // Offset in the x and y direction
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            // Add button functionality here
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white), // Button background color
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0), // Button border radius
                              ),
                            ),
                            elevation: MaterialStateProperty.all(0), // Set button elevation to 0
                            overlayColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors.grey; // Change color on pressed
                                }
                                return Colors.white; // Set default overlay color
                              },
                            ),
                            minimumSize: MaterialStateProperty.all(const Size(800, 40)), // Adjust the width and height
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: Image.asset(
                                  'assets/images/PhoneIcon.png', // asset icon
                                  width: 26,
                                  height: 26,
                                ),
                              ),
                              SizedBox(width: 10,),
                              const Text(
                                '+63-950 441 0844',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: "Inter",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    //Chat Now
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Chat Now",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 5,),

                    //Chat Now Button
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3), // Adjusted shadow color and opacity
                              spreadRadius: 1, // Reduced spread radius
                              blurRadius: 10, // Reduced blur radius
                              offset: Offset(0, 2), // Offset in the x and y direction
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ChatScreen()),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white), // Button background color
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0), // Button border radius
                              ),
                            ),
                            elevation: MaterialStateProperty.all(0), // Set button elevation to 0
                            overlayColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors.grey; // Change color on pressed
                                }
                                return Colors.white; // Set default overlay color
                              },
                            ),
                            minimumSize: MaterialStateProperty.all(const Size(800, 40)), // Adjust the width and height
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: Image.asset(
                                  'assets/images/ChatNowIcon.png', // asset icon
                                  width: 26,
                                  height: 26,
                                ),
                              ),
                              SizedBox(width: 10,),
                              const Text(
                                'Chat us now',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 166,),
                              SizedBox(
                                child: Image.asset(
                                  'assets/images/RightArrow.png', // asset icon
                                  width: 26,
                                  height: 26,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          buildFooter(
            [false, false, false, false, true],
            context,
          ),
        ],
      ),
    );
  }
}