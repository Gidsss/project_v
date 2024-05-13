import 'package:flutter/material.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/adminHeader.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/adminfooter.dart';
import 'package:project_v/screens/admin/manage/addnewcoupons.dart';
import 'package:project_v/screens/admin/manage/allcoupons.dart';
import 'package:project_v/screens/admin/manage/addnewnotificationstemplate.dart';
import 'package:project_v/screens/admin/manage/allnotificationstemplate.dart';
import 'package:project_v/screens/admin/manage/addnewcategory.dart';
import 'package:project_v/screens/admin/manage/allcategories.dart';

class ManagementScreen extends StatefulWidget {
  const ManagementScreen({super.key});

  @override
  State<ManagementScreen> createState() => _ManagementScreenState();
}

class _ManagementScreenState extends State<ManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AdminHeader(context: context),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Coupons Management
                    createHeader("Coupons Management"),
                    createButton(context, 'assets/images/AddNewCouponsIcon.png',
                        'Add New Coupons', const AddNewCouponsScreen()),
                    const SizedBox(
                      height: 15,
                    ),
                    createButton(context, 'assets/images/AllCouponsIcon.png',
                        'All Coupons', const AllCouponsScreen()),
                    const SizedBox(
                      height: 15,
                    ),

                    //Notifications Management
                    createHeader("Notifications Management"),
                    createButton(
                        context,
                        'assets/images/AddNewCouponsIcon.png',
                        'Add New Notification Template',
                        const AddNewNotificationsTemplateScreen()),
                    const SizedBox(
                      height: 15,
                    ),
                    createButton(
                        context,
                        'assets/images/AllNotificationsTemplateIcon.png',
                        'All Notification Templates',
                        const AllNotificationsTemplateScreen()),
                    const SizedBox(
                      height: 15,
                    ),

                    //Categories Management
                    //Notifications Management
                    createHeader("Categories Management"),
                    createButton(context, 'assets/images/AddNewCouponsIcon.png',
                        'Add New Category', const AddNewCategoryScreen()),
                    const SizedBox(
                      height: 15,
                    ),
                    createButton(context, 'assets/images/AllCategoriesIcon.png',
                        'All Categories', const AllCategoryScreen()),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
          AdminFooter(
            buttonStatus: const [false, false, true, false, false],
            context: context,
          ),
        ],
      ),
    );
  }
}

Widget createButton(BuildContext context, String imageIcon, String labelText,
    Widget destination) {
  return ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => destination),
      );
    },
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
          Colors.grey.shade100), // Button background color
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Button border radius
        ),
      ),
      elevation: MaterialStateProperty.all(0), // Set button elevation to 0
      overlayColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.black.withOpacity(0.1); // Change color on hover
          }
          return Colors.grey.shade50; // Set default overlay color
        },
      ),
      minimumSize: MaterialStateProperty.all(
          const Size(1000, 80)), // Adjust the width and height
    ),
    child: SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 26,
            height: 26,
            child: Image.asset(
              imageIcon, // asset icon
              width: 26,
              height: 26,
            ),
          ),
          SizedBox(
            width: 170,
            child: Text(
              labelText,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontFamily: "Inter",
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: 26,
            height: 26,
            child: Image.asset(
              'assets/images/RightArrow.png', // asset icon
              width: 26,
              height: 26,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget createHeader(String text) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontFamily: "Inter",
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ],
  );
}
