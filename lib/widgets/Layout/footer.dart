import 'package:flutter/material.dart';
import 'package:project_v/constants/app_constants.dart';
import 'package:project_v/screens/main/explorescreen.dart';
import 'package:project_v/screens/main/ordersscreen.dart';
import 'package:project_v/screens/main/profilescreen.dart';
import 'package:project_v/screens/main/homescreen.dart';
import 'package:project_v/screens/main/schedulescreen.dart';


Widget buildFooter(List<bool> buttonStatus, BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buttonStatus[0]
                ? buildButton("Home", Icons.home, buttonStatus[0], () {})
                : buildButton("Home", Icons.home_outlined, buttonStatus[0], () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                  }),
            buttonStatus[1]
                ? buildButton("Explore", Icons.explore, buttonStatus[1], () {})
                : buildButton(
                    "Explore", Icons.explore_outlined, buttonStatus[1], () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ExploreScreen()));
                  }),
            buttonStatus[2]
                ? buildButton(
                    "Schedule", Icons.calendar_month, buttonStatus[2], () {})
                : buildButton(
                    "Schedule", Icons.calendar_month_outlined, buttonStatus[2],
                    () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ScheduleScreen()));
                  }),
            buttonStatus[3]
                ? buildButton(
                    "Orders", Icons.local_shipping, buttonStatus[3], () {})
                : buildButton(
                    "Orders", Icons.local_shipping_outlined, buttonStatus[3],
                    () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OrdersScreen()));
                  }),
            buttonStatus[4]
                ? buildButton(
                    "Profile", Icons.account_circle, buttonStatus[4], () {})
                : buildButton(
                    "Profile", Icons.account_circle_outlined, buttonStatus[4],
                    () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileScreen()));
                  }),
          ],
        ),
      ),
    );
  }

  Widget buildButton(
      String label, IconData icon, bool isScreen, void Function() navigate) {
    return Expanded(
      // If isScreen is true, the button has a top border and different background color. Else button no border and white bg color.
      child: isScreen
          ? Container(
              decoration: const BoxDecoration(
                  border: Border(top: BorderSide(width: 1.5))),
              child: TextButton(
                  onPressed: () {
                    navigate();
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFFF4F4F4))),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 4,
                      ),
                      Icon(
                        icon,
                        size: 34,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        label,
                        style:
                            const TextStyle(fontSize: 13, color: Colors.black),
                      ),
                    ],
                  )),
            )
          : TextButton(
              onPressed: () {
                navigate(); // Pass argument here to Navigate to screen Logic which is to follow
              },
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
              child: Column(
                children: [
                  const SizedBox(
                    height: 4,
                  ),
                  Icon(
                    icon,
                    size: 34,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    label,
                    style: const TextStyle(fontSize: 13, color: Colors.black),
                  ),
                ],
              )),
    );
  }

  Widget headerIconButton(
    IconData icon,
  ) {
    return IconButton(
      onPressed: () {
        // Pass argument here to Navigate to screen Logic which is to follow
      },
      icon: Icon(
        icon,
        size: 30,
      ),
      color: Colors.black,
      padding: const EdgeInsets.all(0),
      constraints: const BoxConstraints(),
      style: const ButtonStyle(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }