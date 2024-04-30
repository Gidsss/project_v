import 'package:flutter/material.dart';

import 'package:project_v/widgets/CustomFooterHeaderWidgets/customerheaderfooter.dart';
import 'package:project_v/screens/customer/profile/aboutus.dart';
import 'package:project_v/screens/customer/orders/ordersscreen.dart';
import 'package:project_v/screens/customer/appointment/schedulescreen.dart';
import 'package:project_v/screens/customer/profile/editprofile.dart';
import 'package:project_v/screens/customer/profile/securitysettings.dart';
import 'package:project_v/screens/customer/profile/notificationsettings.dart';
import 'package:project_v/screens/customer/chat/chatscreen.dart';
import 'package:project_v/screens/customer/wishlistscreen.dart';
import 'package:project_v/screens/customer/profile/contactusscreen.dart';
import 'package:project_v/screens/customer/cart/cartscreen.dart';

class ProfileScreen extends StatefulWidget{
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>{

  @override
  Widget build(BuildContext context) {
    return HeaderFooter(
      isProfileFloatbar: true,
      hasFloatbar: false,
      mainHeader: false,
      context: context,
      title: "Screen",
      buttonStatus: const [false, false, false, false, true],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 22), // left padding
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/user.png'),
                  ),
                  SizedBox(width: 15), // Add some space between the image and text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5), // Adjust the vertical spacing if needed
                      Text(
                        "Juan C. Dela Cruz",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Inter",
                        ), // Adjust the font size
                      ),
                      SizedBox(height: 5), // Adjust the vertical spacing if needed
                      Text(
                        "143 Tonton Street, Sta. Mesa Manila, 1012",
                        style: TextStyle(
                          fontSize: 11,
                          fontFamily: "Inter",
                        ), // Adjust the font size
                      ),
                      Text(
                        "+63-9229329901",
                        style: TextStyle(
                          fontSize: 11,
                          fontFamily: "Inter",
                        ), // Adjust the font size
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.only(left: 22),
              child: Text(
                "My Activities",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10.0), // space between the image and the new container
            // My Activities Buttons
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.transparent, // Set shadow color to transparent
                      spreadRadius: 0,
                      blurRadius: 0,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    //Chat and Notification Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ChatScreen()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.grey.shade50), // Button background color
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0), // Button border radius
                          ),
                        ),
                        elevation: MaterialStateProperty.all(0), // Set button elevation to 0
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.black.withOpacity(0.1); // Change color on hover
                            }
                            return Colors.grey.shade50; // Set default overlay color
                          },
                        ),
                        minimumSize: MaterialStateProperty.all(const Size(1000, 50)), // Adjust the width and height
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 26,
                            height: 26,
                            child: Image.asset(
                              'assets/images/Chat&NotifIcon.png', // asset icon
                              width: 26,
                              height: 26,
                            ),
                          ),
                          const SizedBox(width: 8), // Add some space between the icon and text
                          const Text(
                            'Chat & Notification',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 35), // Add some space between the icon and text
                          SizedBox(
                            width: 26,
                            height: 26,
                            child: Image.asset(
                              'assets/images/RightArrow.png', // asset icon
                              width: 26,
                              height: 26,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0), // Add some space between chat & notif button and wishlists button

                    // Wishlists Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const WishlistScreen()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.grey.shade50), // Button background color
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0), // Button border radius
                          ),
                        ),
                        elevation: MaterialStateProperty.all(0), // Set button elevation to 0
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.black.withOpacity(0.1); // Change color on pressed
                            }
                            return Colors.grey.shade50; // Set default overlay color
                          },
                        ),
                        minimumSize: MaterialStateProperty.all(const Size(1000, 50)), // Adjust the width and height
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 26,
                            height: 26,
                            child: Image.asset(
                              'assets/images/WishlistsIcon.png', // asset icon
                              width: 26,
                              height: 26,
                            ),
                          ),
                          const SizedBox(width: 8), // Add some space between the icon and text
                          const Text(
                            'Wishlists',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 120), // Add some space between the icon and text
                          SizedBox(
                            width: 26,
                            height: 26,
                            child: Image.asset(
                              'assets/images/RightArrow.png', // asset icon
                              width: 26,
                              height: 26,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10.0), // Add some space between wishlists button and shopping carts button

                    // Shopping Carts Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CartScreen()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.grey.shade50), // Button background color
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0), // Button border radius
                          ),
                        ),
                        elevation: MaterialStateProperty.all(0), // Set button elevation to 0
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.black.withOpacity(0.1); // Change color on pressed
                            }
                            return Colors.grey.shade50; // Set default overlay color
                          },
                        ),
                        minimumSize: MaterialStateProperty.all(const Size(1000, 50)), // Adjust the width and height
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 26,
                            height: 26,
                            child: Image.asset(
                              'assets/images/ShoppingCartsIcon.png', // asset icon
                              width: 26,
                              height: 26,
                            ),
                          ),
                          const SizedBox(width: 8), // Add some space between the icon and text
                          const Text(
                            'Shopping Carts',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 65), // Add some space between the icon and text
                          SizedBox(
                            width: 26,
                            height: 26,
                            child: Image.asset(
                              'assets/images/RightArrow.png', // asset icon
                              width: 26,
                              height: 26,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10.0), // Add some space between shopping carts button and order button

                    // Order Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const OrdersScreen()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.grey.shade50), // Button background color
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0), // Button border radius
                          ),
                        ),
                        elevation: MaterialStateProperty.all(0), // Set button elevation to 0
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.black.withOpacity(0.1); // Change color on pressed
                            }
                            return Colors.grey.shade50; // Set default overlay color
                          },
                        ),
                        minimumSize: MaterialStateProperty.all(const Size(1000, 50)), // Adjust the width and height
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 26,
                            height: 26,
                            child: Image.asset(
                              'assets/images/OrderIcon.png', // asset icon
                              width: 26,
                              height: 26,
                            ),
                          ),
                          const SizedBox(width: 8), // Add some space between the icon and text
                          const Text(
                            'Order',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 152), // Add some space between the icon and text
                          SizedBox(
                            width: 26,
                            height: 26,
                            child: Image.asset(
                              'assets/images/RightArrow.png', // asset icon
                              width: 26,
                              height: 26,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10.0), // Add some space between order button and view appointment button

                    // View Appointment Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ScheduleScreen()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.grey.shade50), // Button background color
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0), // Button border radius
                          ),
                        ),
                        elevation: MaterialStateProperty.all(0), // Set button elevation to 0
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.black.withOpacity(0.1); // Change color on pressed
                            }
                            return Colors.grey.shade50; // Set default overlay color
                          },
                        ),
                        minimumSize: MaterialStateProperty.all(const Size(1000, 50)), // Adjust the width and height
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 26,
                            height: 26,
                            child: Image.asset(
                              'assets/images/ViewAppointmentIcon.png', // asset icon
                              width: 26,
                              height: 26,
                            ),
                          ),
                          const SizedBox(width: 8), // Add some space between the icon and text
                          const Text(
                            'View Appointment',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 37), // Add some space between the icon and text
                          SizedBox(
                            width: 26,
                            height: 26,
                            child: Image.asset(
                              'assets/images/RightArrow.png', // asset icon
                              width: 26,
                              height: 26,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
            ),


            // My Settings
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.only(left: 22),
              child: Text(
                "My Settings",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10.0), // space between the image and the new container
            // My Settings Buttons
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.transparent, // Set shadow color to transparent
                      spreadRadius: 0,
                      blurRadius: 0,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    //Edit Profile Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const EditProfile()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.grey.shade50), // Button background color
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0), // Button border radius
                          ),
                        ),
                        elevation: MaterialStateProperty.all(0), // Set button elevation to 0
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.black.withOpacity(0.1); // Change color on hover
                            }
                            return Colors.grey.shade50; // Set default overlay color
                          },
                        ),
                        minimumSize: MaterialStateProperty.all(const Size(1000, 50)), // Adjust the width and height
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 26,
                            height: 26,
                            child: Image.asset(
                              'assets/images/EditProfileIcon.png', // asset icon
                              width: 26,
                              height: 26,
                            ),
                          ),
                          const SizedBox(width: 8), // Add some space between the icon and text
                          const Text(
                            'Edit Profile',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 107), // Add some space between the icon and text
                          SizedBox(
                            width: 26,
                            height: 26,
                            child: Image.asset(
                              'assets/images/RightArrow.png', // asset icon
                              width: 26,
                              height: 26,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10.0), // Add some space between Edit Profile button and Security Settings button

                    // Security Settings Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SecuritySettings()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.grey.shade50), // Button background color
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0), // Button border radius
                          ),
                        ),
                        elevation: MaterialStateProperty.all(0), // Set button elevation to 0
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.black.withOpacity(0.1); // Change color on pressed
                            }
                            return Colors.grey.shade50; // Set default overlay color
                          },
                        ),
                        minimumSize: MaterialStateProperty.all(const Size(1000, 50)), // Adjust the width and height
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 26,
                            height: 26,
                            child: Image.asset(
                              'assets/images/SecuritySettingsIcon.png', // asset icon
                              width: 26,
                              height: 26,
                            ),
                          ),
                          const SizedBox(width: 8), // Add some space between the icon and text
                          const Text(
                            'Security Settings',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 50), // Add some space between the icon and text
                          SizedBox(
                            width: 26,
                            height: 26,
                            child: Image.asset(
                              'assets/images/RightArrow.png', // asset icon
                              width: 26,
                              height: 26,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10.0), // Add some space between security settings button and notifications carts button

                    // Notifications Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const NotificationSettings()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.grey.shade50), // Button background color
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0), // Button border radius
                          ),
                        ),
                        elevation: MaterialStateProperty.all(0), // Set button elevation to 0
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.black.withOpacity(0.1); // Change color on pressed
                            }
                            return Colors.grey.shade50; // Set default overlay color
                          },
                        ),
                        minimumSize: MaterialStateProperty.all(const Size(1000, 50)), // Adjust the width and height
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 26,
                            height: 26,
                            child: Image.asset(
                              'assets/images/NotificationsIcon.png', // asset icon
                              width: 26,
                              height: 26,
                            ),
                          ),
                          const SizedBox(width: 8), // Add some space between the icon and text
                          const Text(
                            'Notifications',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 90), // Add some space between the icon and text
                          SizedBox(
                            width: 26,
                            height: 26,
                            child: Image.asset(
                              'assets/images/RightArrow.png', // asset icon
                              width: 26,
                              height: 26,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10.0), // Add some space between Notifications button and About Us button

                    // About Us
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AboutUs()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.grey.shade50), // Button background color
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0), // Button border radius
                          ),
                        ),
                        elevation: MaterialStateProperty.all(0), // Set button elevation to 0
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.black.withOpacity(0.1); // Change color on pressed
                            }
                            return Colors.grey.shade50; // Set default overlay color
                          },
                        ),
                        minimumSize: MaterialStateProperty.all(const Size(1000, 50)), // Adjust the width and height
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 26,
                            height: 26,
                            child: Image.asset(
                              'assets/images/AboutUsIcon.png', // asset icon
                              width: 26,
                              height: 26,
                            ),
                          ),
                          const SizedBox(width: 8), // Add some space between the icon and text
                          const Text(
                            'About Us',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 122), // Add some space between the icon and text
                          SizedBox(
                            width: 26,
                            height: 26,
                            child: Image.asset(
                              'assets/images/RightArrow.png', // asset icon
                              width: 26,
                              height: 26,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10.0), // Add some space between About Us button and Log-out button

                    // Log-out Button
                    ElevatedButton(
                      onPressed: () {
                        // Add button functionality here
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.grey.shade50), // Button background color
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0), // Button border radius
                          ),
                        ),
                        elevation: MaterialStateProperty.all(0), // Set button elevation to 0
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.black.withOpacity(0.1); // Change color on pressed
                            }
                            return Colors.grey.shade50; // Set default overlay color
                          },
                        ),
                        minimumSize: MaterialStateProperty.all(const Size(1000, 50)), // Adjust the width and height
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 26,
                            height: 26,
                            child: Image.asset(
                              'assets/images/LogoutIcon.png', // asset icon
                              width: 26,
                              height: 26,
                            ),
                          ),
                          const SizedBox(width: 8), // Add some space between the icon and text
                          const Text(
                            'Log-out',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 132), // Add some space between the icon and text
                          SizedBox(
                            width: 26,
                            height: 26,
                            child: Image.asset(
                              'assets/images/RightArrow.png', // asset icon
                              width: 26,
                              height: 26,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
            ),

            // Customer Assistance
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.only(left: 22),
              child: Text(
                "Customer Assistance",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10.0), // Space between the image and the new container
            // Customer Assistance Buttons
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.transparent, // Set shadow color to transparent
                    spreadRadius: 0,
                    blurRadius: 0,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Contact Us Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ContactUsScreen()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.grey.shade50), // Button background color
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0), // Button border radius
                        ),
                      ),
                      elevation: MaterialStateProperty.all(0), // Set button elevation to 0
                      overlayColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.black.withOpacity(0.1); // Change color on hover
                          }
                          return Colors.grey.shade50; // Set default overlay color
                        },
                      ),
                      minimumSize: MaterialStateProperty.all(const Size(1000, 50)), // Adjust the width and height
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 26,
                          height: 26,
                          child: Image.asset(
                            'assets/images/ContactUsIcon.png', // asset icon
                            width: 26,
                            height: 26,
                          ),
                        ),
                        const SizedBox(width: 8), // Add some space between the icon and text
                        const Text(
                          'Contact Us',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 104), // Add some space between the icon and text
                        SizedBox(
                          width: 26,
                          height: 26,
                          child: Image.asset(
                            'assets/images/RightArrow.png', // asset icon
                            width: 26,
                            height: 26,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 70.0), // Additional vertical space after the Container
          ],
        ),
      ),
    );
  }}


