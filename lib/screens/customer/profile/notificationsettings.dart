import 'package:flutter/material.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/customerfooter.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/header2.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key});

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  bool isSwitchedSON = false;
  bool isSwitchedDN = false;
  bool isSwitchedWN = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header2(text: "Notification Settings"),
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
                      "Manage Notification",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
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
                          //Special Offer Notifications
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
                                        'assets/images/SpecialOfferNotificationsIcon.png', // asset icon
                                        width: 30,
                                        height: 30,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Special Offer Notifications",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Text(
                                          "Receive notification about "
                                              "\nspecial offers that we may "
                                              "\nhave with your email.",
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
                                  value: isSwitchedSON,
                                  onChanged: (value) {
                                    setState(() {
                                      isSwitchedSON = value;
                                      print(isSwitchedSON);
                                    });
                                  },
                                  activeTrackColor: Colors.grey,
                                  activeColor: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12,),

                          //Delivery Notification
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
                                        'assets/images/DeliveryNotificationIcon.png', // asset icon
                                        width: 30,
                                        height: 30,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Delivery Notifications",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Text(
                                          "Receive a notice when a pick-up "
                                              "\nis being ready with your email.",
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
                                  value: isSwitchedDN,
                                  onChanged: (value) {
                                    setState(() {
                                      isSwitchedDN = value;
                                      print(isSwitchedDN);
                                    });
                                  },
                                  activeTrackColor: Colors.grey,
                                  activeColor: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12,),

                          //Wishlist Notification
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
                                        'assets/images/WishlistsIcon.png', // asset icon
                                        width: 30,
                                        height: 30,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Wishlists Notifications",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Text(
                                          "Receive notification when one "
                                              "\nof your wishlist is on sale or out "
                                              "\nof stock with your email.",
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
                                  value: isSwitchedWN,
                                  onChanged: (value) {
                                    setState(() {
                                      isSwitchedWN = value;
                                      print(isSwitchedWN);
                                    });
                                  },
                                  activeTrackColor: Colors.grey,
                                  activeColor: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15,),
                        ],
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
      // Call the method using the instance
    );
  }
}
