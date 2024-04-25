import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_v/constants/app_constants.dart';
import 'package:project_v/widgets/textfields/textfield.dart';
import 'package:project_v/widgets/Layout/footer.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController editNameController = TextEditingController();
  final TextEditingController editEmailController = TextEditingController();
  final TextEditingController editAddressController = TextEditingController();// Define the controller
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        shadowColor: Colors.black.withOpacity(0.4),
        elevation: 4,
        toolbarHeight: 80,
        centerTitle: true,
        title: Image.asset(
          AppConstants.logoImagePath,
          width: 40,
          height: 40,
        ),
        bottom: const PreferredSize(
          preferredSize: Size.zero,
          child: Text(
            "Edit Profile",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.only(left: 22), // left padding
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundImage: AssetImage('assets/images/user.png'),
                        ),
                        SizedBox(width: 25), // Add some space between the image and text
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 45), // Adjust the vertical spacing if needed
                            ElevatedButton(
                              onPressed: () {
                                // Add button functionality here
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.black), // Button background color
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
                                    return Colors.black; // Set default overlay color
                                  },
                                ),
                                minimumSize: MaterialStateProperty.all(Size(125, 40)), // Adjust the width and height
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Edit Photo',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 20), // Add some space between the icon and text
                                  SizedBox(
                                    width: 18,
                                    height: 17,
                                    child: Image.asset(
                                      'assets/images/EditIcon.png', // asset icon
                                      width: 18,
                                      height: 17,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 70),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // EDIT NAME
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 10), // Adjust horizontal padding as needed
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Name",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 6), // Add some space between the icon and text
                            SizedBox(
                              width: 18,
                              height: 17,
                              child: Image.asset(
                                'assets/images/EditIconBlack.png', // asset icon
                                width: 18,
                                height: 17,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10), // Add vertical space between the text and text field
                        MyTextField(
                          controller: editNameController, // Pass the controller
                          hintText: 'Enter your name',
                          obscureText: false,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Name',
                          ),
                        ),
                        SizedBox(height: 14),
                      ],
                    ),
                  ),

                  //EDIT EMAIL
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 10), // Adjust horizontal padding as needed
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Email",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 6), // Add some space between the icon and text
                            SizedBox(
                              width: 18,
                              height: 17,
                              child: Image.asset(
                                'assets/images/EditIconBlack.png', // asset icon
                                width: 18,
                                height: 17,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10), // Add vertical space between the text and text field
                        MyTextField(
                          controller: editEmailController, // Pass the controller
                          hintText: 'Enter your email',
                          obscureText: false,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                          ),
                        ),
                        SizedBox(height: 14),
                      ],
                    ),
                  ),

                  //EDIT ADDRESS
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 10), // Adjust horizontal padding as needed
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Address",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 6), // Add some space between the icon and text
                            SizedBox(
                              width: 18,
                              height: 17,
                              child: Image.asset(
                                'assets/images/EditIconBlack.png', // asset icon
                                width: 18,
                                height: 17,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10), // Add vertical space between the text and text field
                        MyTextField(
                          controller: editAddressController, // Pass the controller
                          hintText: 'Enter your address',
                          obscureText: false,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Address',
                          ),
                        ),
                        SizedBox(height: 50),

                        //Save Edit Button
                        Center( // Center widget added here
                          child: ElevatedButton(
                            onPressed: () {
                              // Add button functionality here
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.black), // Button background color
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
                                  return Colors.black; // Set default overlay color
                                },
                              ),
                              minimumSize: MaterialStateProperty.all(Size(290, 40)), // Adjust the width and height
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Save',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 70),
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
