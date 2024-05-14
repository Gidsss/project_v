import 'package:flutter/material.dart';
import 'package:project_v/screens/admin/manage/management.dart';
import 'package:project_v/screens/admin/admindashboard.dart';
import 'package:project_v/screens/admin/orders/ordersmadescreen.dart';
import 'package:project_v/screens/admin/products/productmanagement.dart';
import 'package:project_v/screens/admin/profile/adminprofilescreen.dart';


class AdminFooter extends StatelessWidget {
  const AdminFooter({super.key, required this.buttonStatus, required this.context});  
  final List<bool> buttonStatus;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return buildFooter(buttonStatus, context);
  }
}

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
                          builder: (context) => const AdminDashboardScreen()));
                }),
          buttonStatus[1]
              ? buildButton(
                  "Products", Icons.local_offer, buttonStatus[1], () {})
              : buildButton(
                  "Products", Icons.local_offer_outlined, buttonStatus[1], () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProductsScreen()));
                }),
          buttonStatus[2]
              ? buildButton("Manage", Icons.star, buttonStatus[2], () {})
              : buildButton(
                  "Manage", Icons.star_border_outlined, buttonStatus[2], () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ManagementScreen()));
                }),
          buttonStatus[3]
              ? buildButton(
                  "Orders", Icons.calendar_month, buttonStatus[3], () {})
              : buildButton(
                  "Orders", Icons.calendar_month_outlined, buttonStatus[3],
                  () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OrdersMadeScreen()));
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
                          builder: (context) => const AdminProfileScreen()));
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
                      style: const TextStyle(fontSize: 11, color: Colors.black),
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
                  style: const TextStyle(fontSize: 11, color: Colors.black),
                ),
              ],
            )),
  );
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
