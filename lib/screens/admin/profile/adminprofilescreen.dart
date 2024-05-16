import 'package:flutter/material.dart';
import 'package:project_v/screens/admin/profile/viewprofile.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/adminHeader.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/adminfooter.dart';
import 'package:project_v/screens/auth/log-in/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../customersupport.dart';

class AdminProfileScreen extends StatefulWidget{
  const AdminProfileScreen({super.key});

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
  }

class _AdminProfileScreenState extends State<AdminProfileScreen>{
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
          ))
      );
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
        body: Column(
          children: [
            AdminHeader(context: context),
            Expanded(
              child: SingleChildScrollView(
                child: Container (
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                          height: 20
                      ),
                      Padding(padding: const EdgeInsets.only(
                          left: 22
                      ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: _imageFile != null
                                  ? FileImage(_imageFile!) as ImageProvider
                                  : userProfilePic != null
                                  ? NetworkImage(userProfilePic!)
                                  : user?.photoURL != null
                                  ? NetworkImage(user!.photoURL!)
                                  : const AssetImage('assets/images/user.png')
                              as ImageProvider,
                            ),
                            const SizedBox(
                                width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const SizedBox(
                                    height: 5
                                ),
                                Text(
                                  user?.displayName ?? userName ?? "Your Name",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Inter",
                                  ),
                                ),
                                const SizedBox(
                                    height: 5
                                ),
                                Text(
                                  user?.email ??
                                      "your-email@example.com",
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontFamily: "Inter",
                                  ),
                                ),
                                Text(
                                  userAddress ??
                                      "No address provided",
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
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                          height: 40
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                            left: 22
                        ),
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
                          height: 10
                      ),
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
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ViewProfileScreen()),
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
                                    1000, 50)
                                ), // Adjust the width and height
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
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                      width: screenWidth * 0.02),
                                  const Text(
                                    'View Profile',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                      width: screenWidth * 0.23),
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
                                height: 10.0
                            ),/*
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const CustomerSupportScreen()),
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
                                    width: 26,
                                    height: 26,
                                    child: Image.asset(
                                      'assets/images/Chat&NotifIcon.png', // asset icon
                                      width: 26,
                                      height: 26,
                                    ),
                                  ),
                                  const SizedBox(
                                      width:
                                      8), // Add some space between the icon and text
                                  const Text(
                                    'Customer Support',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                      width:
                                      35), // Add some space between the icon and text
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
                            const SizedBox(
                                height: 10.0
                            ),
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
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            AdminFooter(
            buttonStatus: const [false, false, false, false, true], context: context)
          ],
        )
    );
  }
}

