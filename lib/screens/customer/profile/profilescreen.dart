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
import 'package:project_v/screens/auth/log-in/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/header2.dart';
import 'package:project_v/screens/customer/notifications/notificationsscreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser;
  bool _isSigningOut = false;
  String? userName;
  String? userAddress;
  String? userPhone;
  String? userProfilePic;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    getUserProfile();
  }

  void getUserProfile() async {
    if (user != null) {
      try {
        var userData = await FirebaseFirestore.instance
            .collection('customers') // customers table
            .doc(user?.uid)
            .get();
        setState(() {
          userName = userData.data()?['name'];
          userAddress = userData.data()?['address'];
          userPhone = userData.data()?['phoneNumber'];
          userProfilePic = userData.data()?['profilePic'];
        });
      } catch (e) {
        print('Failed to fetch user data: $e');
      }
    }
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void signOut() async {
    setState(() {
      _isSigningOut = true; // Start the sign-out process
    });
    await Future.delayed(
        const Duration(seconds: 1)); // added delay for visual effect
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => LoginScreen(
                title: 'Valdopeña Opticals',
              )));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Failed to sign out: $e")));
    } finally {
      setState(() {
        _isSigningOut = false; // End the sign-out process
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the size of the screen
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    return Scaffold(
      appBar: Header2(text: 'Profile'), // Using Header2 as the AppBar
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.05), // left padding
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          child: ClipOval(
                            child: _imageFile != null
                                ? Image.file(
                                    _imageFile!,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  )
                                : userProfilePic != null
                                    ? Image.network(
                                        userProfilePic!,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) return child;
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress.expectedTotalBytes != null
                                                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        },
                                      )
                                    : user?.photoURL != null
                                        ? Image.network(
                                            user!.photoURL!,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                              if (loadingProgress == null) return child;
                                              return Center(
                                                child: CircularProgressIndicator(
                                                  value: loadingProgress.expectedTotalBytes != null
                                                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                      : null,
                                                ),
                                              );
                                            },
                                          )
                                        : const Image(
                                            image: AssetImage('assets/images/user.png'),
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                          ),
                        ),
                        const SizedBox(
                            width: 15), // Add some space between the image and text
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(
                                height: 5), // Adjust the vertical spacing if needed
                            Text(
                              user?.displayName ?? userName ?? "Your Name",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Inter",
                              ),
                            ),
                            const SizedBox(
                                height: 5), // Adjust the vertical spacing if needed
                            Text(
                              user?.email ??
                                  "your-email@example.com", // Display the user's email
                              style: const TextStyle(
                                fontSize: 11,
                                fontFamily: "Inter",
                              ),
                            ),
                            Text(
                              userAddress ??
                                  "No address provided", // Display the user's email
                              style: const TextStyle(
                                fontSize: 11,
                                fontFamily: "Inter",
                              ),
                            ),
                            Text(
                              userPhone ?? "+63-9229329901",
                              style: const TextStyle(
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
                  const SizedBox(
                      height: 10.0), // space between the image and the new container
                  // My Activities Buttons
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: const [
                          BoxShadow(
                            color:
                            Colors.transparent, // Set shadow color to transparent
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
                                MaterialPageRoute(
                                    builder: (context) => const NotificationsScreen()),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.grey.shade50), // Button background color
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8.0), // Button border radius
                                ),
                              ),
                              elevation: MaterialStateProperty.all(
                                  0), // Set button elevation to 0
                              overlayColor: MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Colors.black
                                        .withOpacity(0.1); // Change color on hover
                                  }
                                  return Colors
                                      .grey.shade50; // Set default overlay color
                                },
                              ),
                              minimumSize: MaterialStateProperty.all(const Size(
                                  1000, 50)), // Adjust the width and height
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: screenWidth * 0.06,
                                  height: screenHeight * 0.06,
                                  child: Image.asset(
                                    'assets/images/Chat&NotifIcon.png', // asset icon
                                    width: screenWidth * 0.06,
                                    height: screenHeight * 0.06,
                                  ),
                                ),
                                SizedBox(
                                    width: screenWidth * 0.02),  // Add some space between the icon and text
                                const Text(
                                  'Notifications',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                    width: screenWidth * 0.18),// Add some space between the icon and text
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


                          const SizedBox(
                              height:
                              10.0),
                               // Add some space between chat & notif button and wishlists button
                           
/*
                          // Wishlists Button
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const WishlistScreen()),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.grey.shade50), // Button background color
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8.0), // Button border radius
                                ),
                              ),
                              elevation: MaterialStateProperty.all(
                                  0), // Set button elevation to 0
                              overlayColor: MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Colors.black
                                        .withOpacity(0.1); // Change color on pressed
                                  }
                                  return Colors
                                      .grey.shade50; // Set default overlay color
                                },
                              ),
                              minimumSize: MaterialStateProperty.all(const Size(
                                  1000, 50)), // Adjust the width and height
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
                                const SizedBox(
                                    width:
                                    8), // Add some space between the icon and text
                                const Text(
                                  'Wishlists',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                    width:
                                    113), // Add some space between the icon and text
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

                          const SizedBox(
                              height:
                              10.0), // Add some space between wishlists button and shopping carts button
*/
                          // Shopping Carts Button
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CartScreen()),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.grey.shade50), // Button background color
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8.0), // Button border radius
                                ),
                              ),
                              elevation: MaterialStateProperty.all(
                                  0), // Set button elevation to 0
                              overlayColor: MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Colors.black
                                        .withOpacity(0.1); // Change color on pressed
                                  }
                                  return Colors
                                      .grey.shade50; // Set default overlay color
                                },
                              ),
                              minimumSize: MaterialStateProperty.all(const Size(
                                  1000, 50)), // Adjust the width and height
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: screenWidth * 0.06,
                                  height: screenHeight * 0.06,
                                  child: Image.asset(
                                    'assets/images/ShoppingCartsIcon.png', // asset icon
                                    width: screenWidth * 0.06,
                                    height: screenHeight * 0.06,
                                  ),
                                ),
                                SizedBox(
                                    width: screenWidth * 0.02),// Add some space between the icon and text
                                const Text(
                                  'Shopping Carts',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                    width: screenWidth * 0.14),  // Add some space between the icon and text
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

                          const SizedBox(
                              height:
                              10.0), // Add some space between shopping carts button and order button

                          // Order Button
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const OrdersScreen()),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.grey.shade50), // Button background color
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8.0), // Button border radius
                                ),
                              ),
                              elevation: MaterialStateProperty.all(
                                  0), // Set button elevation to 0
                              overlayColor: MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Colors.black
                                        .withOpacity(0.1); // Change color on pressed
                                  }
                                  return Colors
                                      .grey.shade50; // Set default overlay color
                                },
                              ),
                              minimumSize: MaterialStateProperty.all(const Size(
                                  1000, 50)), // Adjust the width and height
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: screenWidth * 0.06,
                                  height: screenHeight * 0.06,
                                  child: Image.asset(
                                    'assets/images/OrderIcon.png', // asset icon
                                    width: screenWidth * 0.06,
                                    height: screenHeight * 0.06,
                                  ),
                                ),
                                SizedBox(
                                    width: screenWidth * 0.02), // Add some space between the icon and text
                                const Text(
                                  'Order',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                    width: screenWidth * 0.37), // Add some space between the icon and text
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

                          const SizedBox(
                              height:
                              10.0) // Add some space between order button and view appointment button

                          // View Appointment Button
                          /*ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ScheduleScreen()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Colors.grey.shade50), // Button background color
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8.0), // Button border radius
                          ),
                        ),
                        elevation: MaterialStateProperty.all(
                            0), // Set button elevation to 0
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.black
                                  .withOpacity(0.1); // Change color on pressed
                            }
                            return Colors
                                .grey.shade50; // Set default overlay color
                          },
                        ),
                        minimumSize: MaterialStateProperty.all(const Size(
                            1000, 50)), // Adjust the width and height
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
                          const SizedBox(
                              width:
                                  8), // Add some space between the icon and text
                          const Text(
                            'View Appointment',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                              width:
                                  37), // Add some space between the icon and text
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
                    ),*/
                        ],
                      )),

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
                  const SizedBox(
                      height: 10.0), // space between the image and the new container
                  // My Settings Buttons
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: const [
                          BoxShadow(
                            color:
                            Colors.transparent, // Set shadow color to transparent
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
                                MaterialPageRoute(
                                    builder: (context) => const EditProfile()),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.grey.shade50), // Button background color
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8.0), // Button border radius
                                ),
                              ),
                              elevation: MaterialStateProperty.all(
                                  0), // Set button elevation to 0
                              overlayColor: MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Colors.black
                                        .withOpacity(0.1); // Change color on hover
                                  }
                                  return Colors
                                      .grey.shade50; // Set default overlay color
                                },
                              ),
                              minimumSize: MaterialStateProperty.all(const Size(
                                  1000, 50)), // Adjust the width and height
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: screenWidth * 0.06,
                                  height: screenHeight * 0.06,
                                  child: Image.asset(
                                    'assets/images/EditProfileIcon.png', // asset icon
                                    width: screenWidth * 0.06,
                                    height: screenHeight * 0.06,
                                  ),
                                ),
                                SizedBox(
                                    width: screenWidth * 0.02),// Add some space between the icon and text
                                const Text(
                                  'Edit Profile',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                    width: screenWidth * 0.25),// Add some space between the icon and text
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

                          const SizedBox(
                              height:
                              10.0), // Add some space between Edit Profile button and Security Settings button

                          // Security Settings Button
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SecuritySettings()),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.grey.shade50), // Button background color
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8.0), // Button border radius
                                ),
                              ),
                              elevation: MaterialStateProperty.all(
                                  0), // Set button elevation to 0
                              overlayColor: MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Colors.black
                                        .withOpacity(0.1); // Change color on pressed
                                  }
                                  return Colors
                                      .grey.shade50; // Set default overlay color
                                },
                              ),
                              minimumSize: MaterialStateProperty.all(const Size(
                                  1000, 50)), // Adjust the width and height
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: screenWidth * 0.06,
                                  height: screenHeight * 0.06,
                                  child: Image.asset(
                                    'assets/images/SecuritySettingsIcon.png', // asset icon
                                    width: screenWidth * 0.06,
                                    height: screenHeight * 0.06,
                                  ),
                                ),
                                SizedBox(
                                    width: screenWidth * 0.02),// Add some space between the icon and text
                                const Text(
                                  'Security Settings',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                    width: screenWidth * 0.1), // Add some space between the icon and text
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

                          const SizedBox(
                              height:
                              10.0), // Add some space between security settings button and notifications carts button
/*
                          // Notifications Button
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const NotificationSettings()),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.grey.shade50), // Button background color
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8.0), // Button border radius
                                ),
                              ),
                              elevation: MaterialStateProperty.all(
                                  0), // Set button elevation to 0
                              overlayColor: MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Colors.black
                                        .withOpacity(0.1); // Change color on pressed
                                  }
                                  return Colors
                                      .grey.shade50; // Set default overlay color
                                },
                              ),
                              minimumSize: MaterialStateProperty.all(const Size(
                                  1000, 50)), // Adjust the width and height
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
                                const SizedBox(
                                    width:
                                    8), // Add some space between the icon and text
                                const Text(
                                  'Notifications',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                    width:
                                    81), // Add some space between the icon and text
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

                          const SizedBox(
                              height:
                              10.0), // Add some space between Notifications button and About Us button
*/
                          // About Us
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AboutUs()),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.grey.shade50), // Button background color
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8.0), // Button border radius
                                ),
                              ),
                              elevation: MaterialStateProperty.all(
                                  0), // Set button elevation to 0
                              overlayColor: MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Colors.black
                                        .withOpacity(0.1); // Change color on pressed
                                  }
                                  return Colors
                                      .grey.shade50; // Set default overlay color
                                },
                              ),
                              minimumSize: MaterialStateProperty.all(const Size(
                                  1000, 50)), // Adjust the width and height
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: screenWidth * 0.06,
                                  height: screenHeight * 0.06,
                                  child: Image.asset(
                                    'assets/images/AboutUsIcon.png', // asset icon
                                    width: screenWidth * 0.06,
                                    height: screenHeight * 0.06,
                                  ),
                                ),
                                SizedBox(
                                    width: screenWidth * 0.02),// Add some space between the icon and text
                                const Text(
                                  'About Us',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                    width: screenWidth * 0.3),// Add some space between the icon and text
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

                          const SizedBox(
                              height:
                              10.0), // Add some space between About Us button and Log-out button

                          // Log-out Button
                          ElevatedButton(
                            onPressed: () {
                              // Add button functionality here
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.grey.shade50), // Button background color
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8.0), // Button border radius
                                ),
                              ),
                              elevation: MaterialStateProperty.all(
                                  0), // Set button elevation to 0
                              overlayColor: MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Colors.black
                                        .withOpacity(0.1); // Change color on pressed
                                  }
                                  return Colors
                                      .grey.shade50; // Set default overlay color
                                },
                              ),
                              minimumSize: MaterialStateProperty.all(const Size(
                                  1000, 50)), // Adjust the width and height
                            ),
                            child: InkWell(
                              onTap: _isSigningOut
                                  ? null
                                  : signOut, // Disable onTap when signing out
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (!_isSigningOut) ...[
                                    SizedBox(
                                      width: screenWidth * 0.06,
                                      height: screenHeight * 0.06,
                                      child: Image.asset(
                                        'assets/images/LogoutIcon.png',
                                        width: screenWidth * 0.06,
                                        height: screenHeight * 0.06,
                                      ),
                                    ),
                                    SizedBox(
                                        width: screenWidth * 0.02),
                                    const Text(
                                      'Log-out',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                        width: screenWidth * 0.33),
                                    SizedBox(
                                      width: 26,
                                      height: 26,
                                      child: Image.asset(
                                        'assets/images/RightArrow.png',
                                        width: 26,
                                        height: 26,
                                      ),
                                    ),
                                  ] else ...[
                                    const SizedBox(
                                      width: 26,
                                      height: 26,
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                            Colors.black54),
                                        strokeWidth: 3,
                                      ), // Show loading indicator
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'Signing out...',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),

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
                  const SizedBox(
                      height: 10.0), // Space between the image and the new container
                  // Customer Assistance Buttons
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: const [
                        BoxShadow(
                          color:
                          Colors.transparent, // Set shadow color to transparent
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
                              MaterialPageRoute(
                                  builder: (context) => const ContactUsScreen()),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.grey.shade50), // Button background color
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    8.0), // Button border radius
                              ),
                            ),
                            elevation: MaterialStateProperty.all(
                                0), // Set button elevation to 0
                            overlayColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors.black
                                      .withOpacity(0.1); // Change color on hover
                                }
                                return Colors
                                    .grey.shade50; // Set default overlay color
                              },
                            ),
                            minimumSize: MaterialStateProperty.all(
                                const Size(1000, 50)), // Adjust the width and height
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: screenWidth * 0.06,
                                height: screenHeight * 0.06,
                                child: Image.asset(
                                  'assets/images/ContactUsIcon.png', // asset icon
                                  width: screenWidth * 0.06,
                                  height: screenHeight * 0.06,
                                ),
                              ),
                              const SizedBox(
                                  width:
                                  8), // Add some space between the icon and text
                              const Text(
                                'Contact Us',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                  width: screenWidth * 0.25), // Add some space between the icon and text
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
                  const SizedBox(
                      height: 70.0), // Additional vertical space after the Container
                ],
              ),
            ),
          ),
          buildFooter(
            [false, false, false, false, true],
            context,
          ),
        ],
      )

    );
  }
}
