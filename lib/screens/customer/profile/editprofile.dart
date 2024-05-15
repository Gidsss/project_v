import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_v/screens/customer/profile/profilescreen.dart';
import 'dart:io';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/header2.dart';
import 'package:project_v/widgets/textfields/textfield.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/customerfooter.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController editNameController = TextEditingController();
  final TextEditingController editEmailController = TextEditingController();
  final TextEditingController editPhoneController = TextEditingController();
  final TextEditingController editAddressController = TextEditingController();

  final user = FirebaseAuth.instance.currentUser;
  String? userName;
  String? userEmail;
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
            .collection('customers')
            .doc(user?.uid)
            .get();
        setState(() {
          userName = userData.data()?['name'];
          userEmail = userData.data()?['email'];
          userAddress = userData.data()?['address'];
          userPhone = userData.data()?['phoneNumber'];
          userProfilePic = userData.data()?['profilePic'];

          // Set the initial values of the text controllers
          editNameController.text = userName ?? '';
          editEmailController.text = userEmail ?? '';
          editPhoneController.text = userPhone ?? '';
          editAddressController.text = userAddress ?? '';
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

  Future<void> updateOtherFields() async {
    if (user!= null) {
      try {
        String? downloadUrl;
        if (_imageFile!= null) {
          final storageRef = FirebaseStorage.instance
              .ref()
              .child('profilePics/${user!.uid}');
          final uploadTask = storageRef.putFile(_imageFile!);
          final snapshot = await uploadTask.whenComplete(() {});
          downloadUrl = await snapshot.ref.getDownloadURL();
        }

        await FirebaseFirestore.instance
            .collection('customers')
            .doc(user?.uid)
            .update({
          'name': editNameController.text,
          'phoneNumber': editPhoneController.text,
          'address': editAddressController.text,
          if (downloadUrl!= null) 'profilePic': downloadUrl,
        });
      } catch (e) {
        print('Failed to update other fields: $e');
        // Handle the error as needed
      }
    }
  }

  Future<void> reauthenticateAndUpdateEmail() async {
    // Show a dialog to get the current password
    String? currentPassword = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String password = '';
        return AlertDialog(
          title: Text('Reauthenticate'),
          content: TextField(
            onChanged: (value) {
              password = value;
            },
            obscureText: true,
            decoration: InputDecoration(labelText: 'Enter your current password'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(password);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );

    if (currentPassword == null) {
      return; // User canceled the dialog
    }

    try {
      // Reauthenticate
      AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: currentPassword,
      );

      await user!.reauthenticateWithCredential(credential);

      // Verify the current email before updating
      await user!.verifyBeforeUpdateEmail(editEmailController.text);

      print('Email updated successfully');
    } catch (e) {
      print('Failed to update email: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Failed to update email'),
            content: Text('Error: $e'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> saveChanges() async {
    if (user != null) {
      // Update other fields
      await updateOtherFields();

      // Update email if it has changed
      if (user?.email != editEmailController.text) {
        await reauthenticateAndUpdateEmail();
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm'),
            content: Text('Are you sure you want to save changes?'),
            actions: <Widget>[
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  fixedSize: MaterialStateProperty.all<Size>(const Size(100, 35)),
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('No'),
              ),
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  fixedSize: MaterialStateProperty.all<Size>(const Size(100, 35)),
                ),
                onPressed: () {
                  Navigator.of(context).pop(true);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
                child: Text('Yes'),
              ),
            ],
          );
        },
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const Header2(text: "Edit Profile"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 22),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        const SizedBox(width: 25),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 45),
                            ElevatedButton(
                              onPressed: pickImage,
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(40.0),
                                  ),
                                ),
                                elevation: MaterialStateProperty.all(0),
                                overlayColor: MaterialStateProperty.resolveWith<
                                    Color>((Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Colors.grey;
                                  }
                                  return Colors.black;
                                }),
                                minimumSize:
                                MaterialStateProperty.all(const Size(125, 40)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Edit Photo',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  SizedBox(
                                    width: 18,
                                    height: 17,
                                    child: Image.asset(
                                      'assets/images/EditIcon.png',
                                      width: 18,
                                      height: 17,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 70),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
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
                            const SizedBox(width: 6),
                            SizedBox(
                              width: 18,
                              height: 17,
                              child: Image.asset(
                                'assets/images/EditIconBlack.png',
                                width: 18,
                                height: 17,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        MyTextField(
                          controller: editNameController,
                          hintText: 'Enter your name',
                          obscureText: false,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Name',
                          ),
                        ),
                        const SizedBox(height: 14),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
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
                            const SizedBox(width: 6),
                            SizedBox(
                              width: 18,
                              height: 17,
                              child: Image.asset(
                                'assets/images/EditIconBlack.png',
                                width: 18,
                                height: 17,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        MyTextField(
                          controller: editEmailController,
                          hintText: 'Enter your email',
                          obscureText: false,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                          ),
                        ),
                        const SizedBox(height: 14),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Phone Number",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 6),
                            SizedBox(
                              width: 18,
                              height: 17,
                              child: Image.asset(
                                'assets/images/EditIconBlack.png',
                                width: 18,
                                height: 17,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        MyTextField(
                          controller: editPhoneController,
                          hintText: 'Enter your phone number',
                          obscureText: false,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Phone Number',
                          ),
                        ),
                        const SizedBox(height: 14),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Address",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 6),
                            SizedBox(
                              width: 18,
                              height: 17,
                              child: Image.asset(
                                'assets/images/EditIconBlack.png',
                                width: 18,
                                height: 17,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        MyTextField(
                          controller: editAddressController,
                          hintText: 'Enter your address',
                          obscureText: false,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Address',
                          ),
                        ),
                        const SizedBox(height: 50),
                        Center(
                          child: ElevatedButton(
                            onPressed: saveChanges,
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                              ),
                              elevation: MaterialStateProperty.all(0),
                              overlayColor: MaterialStateProperty.resolveWith<
                                  Color>((Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors.grey;
                                }
                                return Colors.black;
                              }),
                              minimumSize: MaterialStateProperty.all(
                                  const Size(290, 40)),
                            ),
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 70),
                      ],
                    ),
                  ),
                ],
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
