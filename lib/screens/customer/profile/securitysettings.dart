import 'package:flutter/material.dart';
import 'package:project_v/constants/app_constants.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/customerfooter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SecuritySettings extends StatefulWidget {
  const SecuritySettings({super.key});

  @override
  State<SecuritySettings> createState() => _SecuritySettingsState();
}

class _SecuritySettingsState extends State<SecuritySettings> {
  bool cpasswordVisible=false;
  bool npasswordVisible=false;
  bool confpasswordVisible=false;

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void _changePassword() async {
    // Get input from text fields
    String currentPassword = currentPasswordController.text.trim();
    String newPassword = newPasswordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    // Validate password match
    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("New password and confirm password do not match."),
        duration: Duration(seconds: 2),
      ));
      return;
    }

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        AuthCredential credential =
        EmailAuthProvider.credential(email: user.email!, password: currentPassword);
        await user.reauthenticateWithCredential(credential);

        await user.updatePassword(newPassword);
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Password changed successfully"),
          duration: Duration(seconds: 2),
        ));

        // Clear text fields after successful password change
        currentPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();
      }
    } catch (error) {
      // Show specific error messages based on error type
      String errorMessage = "Failed to change password. Please try again.";
      if (error is FirebaseAuthException) {
        if (error.code == 'wrong-password') {
          errorMessage = "Incorrect current password. Please try again.";
        } else if (error.code == 'weak-password') {
          errorMessage = "New password is too weak. Please choose a stronger password.";
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
        duration: Duration(seconds: 4),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            "Security Settings",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30,),
                    const Text(
                      "Manage Security",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8.5),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: Colors.grey.shade300, // Add white color for the border
                          width: 2, // Set the width of the border
                        ),
                      ),
                      child: Column(
                        children: [
                          //Change Password
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: Colors.grey.shade200, // Add white color for the border
                                width: 2, // Set the width of the border
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      child: Image.asset(
                                        'assets/images/ChangePasswordIcon.png', // asset icon
                                        width: 30,
                                        height: 30,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 7,),
                                        Text(
                                          "Change Password",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                  ],
                                ),
                                //Current Password
                                const SizedBox(height: 25),
                                const Text(
                                  "Current Password",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextField(
                                  controller: currentPasswordController,
                                  obscureText: cpasswordVisible,
                                  decoration: InputDecoration(
                                    hintText: "Current Password",
                                    helperStyle:const TextStyle(color:Colors.green),
                                    suffixIcon: IconButton(
                                      icon: Icon(cpasswordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                      onPressed: () {
                                        setState(
                                              () {
                                            cpasswordVisible = !cpasswordVisible;
                                          },
                                        );
                                      },
                                    ),
                                    alignLabelWithHint: false,
                                    filled: true,
                                  ),
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.done,
                                ),
                                //New Password
                                const SizedBox(height: 25),
                                const Text(
                                  "New Password",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextField(
                                  controller: newPasswordController,
                                  obscureText: npasswordVisible,
                                  decoration: InputDecoration(
                                    hintText: "New Password",
                                    helperStyle:const TextStyle(color:Colors.green),
                                    suffixIcon: IconButton(
                                      icon: Icon(npasswordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                      onPressed: () {
                                        setState(
                                              () {
                                            npasswordVisible = !npasswordVisible;
                                          },
                                        );
                                      },
                                    ),
                                    alignLabelWithHint: false,
                                    filled: true,
                                  ),
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.done,
                                ),
                                //Confirm New Password
                                const SizedBox(height: 25),
                                const Text(
                                  "Confirm New Password",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextField(
                                  controller: confirmPasswordController,
                                  obscureText: confpasswordVisible,
                                  decoration: InputDecoration(
                                    hintText: "Confirm New Password",
                                    helperStyle:const TextStyle(color:Colors.green),
                                    suffixIcon: IconButton(
                                      icon: Icon(confpasswordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                      onPressed: () {
                                        setState(
                                              () {
                                            confpasswordVisible = !confpasswordVisible;
                                          },
                                        );
                                      },
                                    ),
                                    alignLabelWithHint: false,
                                    filled: true,
                                  ),
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.done,
                                ),
                                const SizedBox(height: 25,),

                                //Save Button
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _changePassword();
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
                                      minimumSize: MaterialStateProperty.all(const Size(190, 40)), // Adjust the width and height
                                    ),
                                    child: const Row(
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 75,),
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
