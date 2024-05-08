import 'package:flutter/material.dart';
import 'package:project_v/constants/app_constants.dart';

import '../../screens/admin/customersupport.dart';


class AdminHeader extends StatefulWidget{
  const AdminHeader({super.key, required this.context});
  final BuildContext context;

  @override
  State<AdminHeader> createState () => AdminHeaderState();
}

class AdminHeaderState extends State<AdminHeader>{

@override
Widget build(BuildContext context){
  return buildmainHeader(context);
}


Widget buildmainHeader(BuildContext context) {
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
                      const SizedBox(width: 8),
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
                  const SizedBox(width: 100),
                  Row(
                    children: [
                      headerIconButton(
                          context,
                          Icons.mark_unread_chat_alt_outlined,
                          const CustomerSupportScreen()),
                      const SizedBox(width: 6),
                    ],
                  ),
                ],
              ),
            ),
          ))));
}

Widget headerIconButton(BuildContext context, IconData icon, Widget page) {
  return IconButton(
    onPressed: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
    },
    icon: Icon(
      icon,
      size: 30,
      color: Colors.black,
    ),
    padding: const EdgeInsets.all(0),
    constraints: const BoxConstraints(),
  );
}
}