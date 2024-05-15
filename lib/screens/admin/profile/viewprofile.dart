import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/header2.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/adminfooter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'adminprofilescreen.dart';

class ViewProfileScreen extends StatefulWidget {
  const ViewProfileScreen({super.key});

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  final user = FirebaseAuth.instance.currentUser;
  String? userName;
  String? userEmail;
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
            .collection('customers')
            .doc(user?.uid)
            .get();
        setState(() {
          userName = userData.data()?['name'];
          userEmail = userData.data()?['email'];
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

  Future<void> saveProfile() async {
    if (_imageFile != null) {
      // Upload image to Firebase Storage
      try {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('profilePics/${user?.uid}');
        await storageRef.putFile(_imageFile!);
        final downloadURL = await storageRef.getDownloadURL();

        // Update Firestore with new profile picture URL
        await FirebaseFirestore.instance
            .collection('customers')
            .doc(user?.uid)
            .update({'profilePic': downloadURL});

        setState(() {
          userProfilePic = downloadURL;
        });
      } catch (e) {
        print('Failed to upload image: $e');
      }
    }

    // Navigate to AdminProfileScreen
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AdminProfileScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const Header2(text: "View Profile"),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 22),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundImage: _imageFile != null
                              ? FileImage(_imageFile!) as ImageProvider
                              : userProfilePic != null
                              ? NetworkImage(userProfilePic!)
                              : user?.photoURL != null
                              ? NetworkImage(user!.photoURL!)
                              : const AssetImage(
                              'assets/images/user.png')
                          as ImageProvider,
                        ),
                        Positioned(
                          right: 5,
                          bottom: 2,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: IconButton(
                              alignment: Alignment.center,
                              iconSize: 15,
                              color: Colors.white,
                              onPressed: pickImage,
                              icon: const Icon(Icons.edit),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Name",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 30,
                          child: TextField(
                            readOnly: true,
                            controller: TextEditingController(
                                text: userName ?? "Your Name"),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Inter',
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Email",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 30,
                          child: TextField(
                            readOnly: true,
                            controller: TextEditingController(
                                text: user?.email ?? "your-email@example.com"),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Inter',
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                  Center(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                        fixedSize: MaterialStateProperty.all<Size>(
                            const Size(250, 35)),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Confirmation"),
                              content: const Text(
                                  "Are you sure you want to save changes?"),
                              actions: [
                                TextButton(
                                  style: ButtonStyle(
                                    foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                    fixedSize: MaterialStateProperty.all<Size>(
                                        const Size(100, 35)),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Cancel"),
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                    fixedSize: MaterialStateProperty.all<Size>(
                                        const Size(100, 35)),
                                  ),
                                  onPressed: () async {
                                    await saveProfile();
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Save"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text("Save"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AdminFooter(
            buttonStatus: const [false, false, false, false, true],
            context: context,
          ),
        ],
      ),
    );
  }
}
