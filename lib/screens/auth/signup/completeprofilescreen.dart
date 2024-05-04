// ignore_for_file: library_private_types_in_public_api
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_v/widgets/buttons/auth/donebutton.dart';
// import 'package:project_v/widgets/img/profilepic.dart';
import 'package:project_v/widgets/textfields/textfield.dart';
import 'package:project_v/screens/auth/log-in/loginscreen.dart';
import 'package:project_v/constants/app_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class CompleteProfileScreen extends StatefulWidget {
  final User user;

  const CompleteProfileScreen({super.key, required this.user});

  @override
  _CompleteProfileScreenState createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final nameController = TextEditingController();
  final phonenumController = TextEditingController();
  final addressController = TextEditingController();
  File? _imageFile;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> completeSignUp(BuildContext context) async {
    if (nameController.text.isNotEmpty &&
        phonenumController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        _imageFile != null) {
      String imageUrl = '';
      try {
        TaskSnapshot uploadTask = await FirebaseStorage.instance
            .ref('profilePics/${widget.user.uid}')
            .putFile(_imageFile!);
        imageUrl = await uploadTask.ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('customers')
            .doc(widget.user.uid)
            .set({
          'name': nameController.text,
          'phoneNumber': phonenumController.text,
          'address': addressController.text,
          'profilePic': imageUrl,
        }, SetOptions(merge: true));

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    LoginScreen(title: 'Valdopeña Opticals')));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Failed to complete profile: ${e.toString()}')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please fill in all fields and select an image.')));
    }
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
                  icon: Image.asset(AppConstants.backIconPath),
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
            Stack(
              children: [
                CircleAvatar(
                  radius: 56,
                  backgroundImage: _imageFile != null
                      ? FileImage(_imageFile!)
                      : const AssetImage(AppConstants.profileIconPath)
                          as ImageProvider,
                ),
                Positioned(
                  right: -10, // Adjust the position as needed
                  bottom: 0,
                  child: IconButton(
                    icon: SvgPicture.asset(AppConstants.editIconPath),
                    onPressed: pickImage,
                    color: Colors.white,
                    iconSize: 46, // Adjust size to fit your design
                  ),
                ),
              ],
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
            DoneButton(onTap: () {
              completeSignUp(context);
            }),
          ],
        ),
      ),
    );
  }
}
