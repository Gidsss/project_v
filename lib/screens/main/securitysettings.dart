import 'package:flutter/material.dart';
import 'package:project_v/constants/app_constants.dart';
import 'package:project_v/widgets/Layout/footer.dart';

class SecuritySettings extends StatefulWidget {
  const SecuritySettings({super.key});

  @override
  State<SecuritySettings> createState() => _SecuritySettingsState();
}

class _SecuritySettingsState extends State<SecuritySettings> {
  bool isSwitchedSA = false;
  bool isSwitchedE2FA = false;
  bool cpasswordVisible=false;
  bool npasswordVisible=false;
  bool confpasswordVisible=false;
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
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30,),
                    Text(
                      "Manage Security",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),

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
                          //Security Alert
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      child: Image.asset(
                                        'assets/images/SecurityAlertIcon.png', // asset icon
                                        width: 30,
                                        height: 30,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Security Alert",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Text(
                                          "Allow users to receive "
                                              "\nalerts for suspicious activities, "
                                              "\nor login attempts.",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.black,
                                            fontFamily: "Inter",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Switch(
                                  value: isSwitchedSA,
                                  onChanged: (value) {
                                    setState(() {
                                      isSwitchedSA = value;
                                      print(isSwitchedSA);
                                    });
                                  },
                                  activeTrackColor: Colors.grey,
                                  activeColor: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          //Enable 2FA
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      child: Image.asset(
                                        'assets/images/Enable2FAIcon.png', // asset icon
                                        width: 30,
                                        height: 30,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Enable 2FA",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Text(
                                          "Logging in with two types "
                                              "\nof security method. User "
                                              "\npassword and OTP via user email.",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.black,
                                            fontFamily: "Inter",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Switch(
                                  value: isSwitchedE2FA,
                                  onChanged: (value) {
                                    setState(() {
                                      isSwitchedE2FA = value;
                                      print(isSwitchedE2FA);
                                    });
                                  },
                                  activeTrackColor: Colors.grey,
                                  activeColor: Colors.black,
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 20,),

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
                                    SizedBox(width: 10),
                                    Column(
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
                                SizedBox(height: 25),
                                Text(
                                  "Current Password",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextField(
                                  obscureText: cpasswordVisible,
                                  decoration: InputDecoration(
                                    hintText: "Current Password",
                                    helperStyle:TextStyle(color:Colors.green),
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
                                SizedBox(height: 25),
                                Text(
                                  "New Password",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextField(
                                  obscureText: npasswordVisible,
                                  decoration: InputDecoration(
                                    hintText: "New Password",
                                    helperStyle:TextStyle(color:Colors.green),
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

                                //Confirm Password
                                //New Password
                                SizedBox(height: 25),
                                Text(
                                  "Confirm Password",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextField(
                                  obscureText: confpasswordVisible,
                                  decoration: InputDecoration(
                                    hintText: "Confirm Password",
                                    helperStyle:TextStyle(color:Colors.green),
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
                                SizedBox(height: 25,),

                                //Save Button
                                Center(
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
                                      minimumSize: MaterialStateProperty.all(const Size(190, 40)), // Adjust the width and height
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
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
                    SizedBox(height: 75,),
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
