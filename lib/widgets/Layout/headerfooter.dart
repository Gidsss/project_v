import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:project_v/constants/app_constants.dart';

class HeaderFooter extends StatefulWidget {
  final Widget body;
  final bool hasDrawer;
  final String title;
  final List<bool> buttonStatus;

  const HeaderFooter(
      {super.key,
      required this.body,
      this.hasDrawer = false,
      required this.title,
      required this.buttonStatus});

  @override
  State<HeaderFooter> createState() => _HeaderFooterState();
}

class _HeaderFooterState extends State<HeaderFooter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        buildheader(),
        Expanded(child: Container(child: widget.body)),
        buildFooter(widget.buttonStatus)
      ],
    ));
  }
}

Widget buildheader() {
  return Material(
      child: Container(
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 4,
        blurRadius: 4,
        offset: const Offset(0, -2),
      ),
    ], color: Colors.white),
    child: Expanded(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Image.asset(
                    AppConstants.logoImagePath,
                    width: 60,
                    height: 60,
                  ),
                  SizedBox(width: 8),
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Valdopeña",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Times New Roman",
                                fontSize: 18,
                                fontWeight: FontWeight.w500)),
                        Text("Opticals",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Times New Roman",
                                fontSize: 18,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(width: 20),
              Row(
                children: [
                  headerIconButton(Icons.mark_unread_chat_alt_outlined),
                  SizedBox(width: 8),
                  headerIconButton(Icons.notifications_outlined),
                  SizedBox(width: 8),
                  headerIconButton(Icons.favorite_border),
                  SizedBox(width: 8),
                  headerIconButton(Icons.shopping_bag_outlined)
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  ));
}

Widget buildFooter(List<bool> buttonStatus) {
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
              ? buildButton("Home", Icons.home, buttonStatus[0])
              : buildButton("Home", Icons.home_outlined, buttonStatus[0]),
          buttonStatus[1]
              ? buildButton("Explore", Icons.explore, buttonStatus[1])
              : buildButton("Explore", Icons.explore_outlined, buttonStatus[1]),
          buttonStatus[2]
              ? buildButton("Schedule", Icons.calendar_month, buttonStatus[2])
              : buildButton(
                  "Schedule", Icons.calendar_month_outlined, buttonStatus[2]),
          buttonStatus[3]
              ? buildButton("Orders", Icons.local_shipping, buttonStatus[3])
              : buildButton(
                  "Orders", Icons.local_shipping_outlined, buttonStatus[3]),
          buttonStatus[4]
              ? buildButton("Home", Icons.account_circle, buttonStatus[4])
              : buildButton(
                  "Profile", Icons.account_circle_outlined, buttonStatus[4]),
        ],
      ),
    ),
  );
}

Widget buildButton(String label, IconData icon, bool isScreen) {
  return Expanded(
    // If isScreen is true, the button has a top border and different background color. Else button no border and white bg color.
    child: isScreen
        ? Container(
            decoration: const BoxDecoration(
                border: Border(top: BorderSide(width: 1.5))),
            child: TextButton(
                onPressed: () {
                  // Pass argument here to Navigate to screen Logic which is to follow
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
                      style: const TextStyle(fontSize: 13, color: Colors.black),
                    ),
                  ],
                )),
          )
        : TextButton(
            onPressed: () {
              // Pass argument here to Navigate to screen Logic which is to follow
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
    padding: EdgeInsets.all(0),
    constraints: const BoxConstraints(),
    style: const ButtonStyle(
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
  );
}
