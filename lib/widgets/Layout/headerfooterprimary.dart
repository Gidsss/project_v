import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:project_v/constants/app_constants.dart';

class headerfooter extends StatefulWidget {
  final Widget body;
  final bool hasDrawer;
  final String title;
  final List<bool> buttonStatus;

  const headerfooter(
      {super.key,
      required this.body,
      this.hasDrawer = false,
      required this.title,
      required this.buttonStatus});

  @override
  State<headerfooter> createState() => _headerfooterState();
}

class _headerfooterState extends State<headerfooter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        buildheader(),
        Expanded(
            child: Container(
                padding: const EdgeInsets.all(15), child: widget.body)),
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
          padding: const EdgeInsets.fromLTRB(15,5,15,10),
          child: Row(
            children: [
              Image.asset(
                AppConstants.logoImagePath,
                width: 60,
                height: 60,
              ),
              RichText(text: const TextSpan(text: "Valdopeña Opticals", style: TextStyle(color: Colors.black, fontFamily: "JosefinSans")))
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
          buildButton("Home", Icons.home, buttonStatus[0]),
          buildButton("Explore", Icons.explore, buttonStatus[1]),
          buildButton("Schedule", Icons.calendar_today, buttonStatus[2]),
          buildButton("Orders", Icons.local_shipping, buttonStatus[3]),
          buildButton("Profile", Icons.account_circle, buttonStatus[4]),
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
                onPressed: () {},
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
            onPressed: () {},
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
