import 'package:flutter/material.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/adminHeader.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/adminfooter.dart';
import 'package:project_v/screens/admin/manage/addnewcoupons.dart';
import 'package:project_v/screens/admin/manage/allcoupons.dart';
import 'package:project_v/screens/admin/manage/addnewnotificationstemplate.dart';
import 'package:project_v/screens/admin/manage/allnotificationstemplate.dart';
import 'package:project_v/screens/admin/manage/addnewcategory.dart';
import 'package:project_v/screens/admin/manage/allcategories.dart';

class ManagementScreen extends StatefulWidget{
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
                    SizedBox(height: 20,),
                    Text(
                      "Coupons Management",
                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.black,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),

                    //Add New Coupons Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddNewCouponsScreen()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Colors.grey.shade100), // Button background color
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8.0), // Button border radius
                          ),
                        ),
                        elevation: MaterialStateProperty.all(
                            0), // Set button elevation to 0
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.black
                                  .withOpacity(0.1); // Change color on hover
                            }
                            return Colors
                                .grey.shade50; // Set default overlay color
                          },
                        ),
                        minimumSize: MaterialStateProperty.all(const Size(
                            1000, 80)), // Adjust the width and height
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 26,
                            height: 26,
                            child: Image.asset(
                              'assets/images/AddNewCouponsIcon.png', // asset icon
                              width: 26,
                              height: 26,
                            ),
                          ),
                          const SizedBox(
                              width:
                              45), // Add some space between the icon and text
                          const Text(
                            'Add New Coupons',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                              width:54), // Add some space between the icon and text
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
                    SizedBox(height: 15,),

                    //All Coupons Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AllCouponsScreen()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Colors.grey.shade100), // Button background color
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8.0), // Button border radius
                          ),
                        ),
                        elevation: MaterialStateProperty.all(
                            0), // Set button elevation to 0
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.black
                                  .withOpacity(0.1); // Change color on hover
                            }
                            return Colors
                                .grey.shade50; // Set default overlay color
                          },
                        ),
                        minimumSize: MaterialStateProperty.all(const Size(
                            1000, 80)), // Adjust the width and height
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 26,
                            height: 26,
                            child: Image.asset(
                              'assets/images/AllCouponsIcon.png', // asset icon
                              width: 26,
                              height: 26,
                            ),
                          ),
                          const SizedBox(
                              width:
                              45), // Add some space between the icon and text
                          const Text(
                            'All Coupons',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                              width:111), // Add some space between the icon and text
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
                    SizedBox(height: 15,),

                    //Notifications Management
                    SizedBox(height: 20,),
                    Text(
                      "Notifications Management",
                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.black,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),

                    //Add New Notification Template Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddNewNotificationsTemplateScreen()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Colors.grey.shade100), // Button background color
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8.0), // Button border radius
                          ),
                        ),
                        elevation: MaterialStateProperty.all(
                            0), // Set button elevation to 0
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.black
                                  .withOpacity(0.1); // Change color on hover
                            }
                            return Colors
                                .grey.shade50; // Set default overlay color
                          },
                        ),
                        minimumSize: MaterialStateProperty.all(const Size(
                            1000, 80)), // Adjust the width and height
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 26,
                            height: 26,
                            child: Image.asset(
                              'assets/images/AddNewCouponsIcon.png', // asset icon
                              width: 26,
                              height: 26,
                            ),
                          ),
                          const SizedBox(
                              width:
                              45), // Add some space between the icon and text
                          const Text(
                            'Add New Notification '
                                '\n           Template',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                              width:26), // Add some space between the icon and text
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
                    SizedBox(height: 15,),

                    //All Notifications Templates Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AllNotificationsTemplateScreen()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Colors.grey.shade100), // Button background color
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8.0), // Button border radius
                          ),
                        ),
                        elevation: MaterialStateProperty.all(
                            0), // Set button elevation to 0
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.black
                                  .withOpacity(0.1); // Change color on hover
                            }
                            return Colors
                                .grey.shade50; // Set default overlay color
                          },
                        ),
                        minimumSize: MaterialStateProperty.all(const Size(
                            1000, 80)), // Adjust the width and height
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 26,
                            height: 26,
                            child: Image.asset(
                              'assets/images/AllNotificationsTemplateIcon.png', // asset icon
                              width: 26,
                              height: 26,
                            ),
                          ),
                          const SizedBox(
                              width:
                              65), // Add some space between the icon and text
                          const Text(
                            'All Notifications '
                                '\n     Templates',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                              width: 53), // Add some space between the icon and text
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
                    SizedBox(height: 15,),

                    //Categories Management
                    SizedBox(height: 20,),
                    Text(
                      "Categories Management",
                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.black,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),

                    //Add New Category Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddNewCategoryScreen()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Colors.grey.shade100), // Button background color
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8.0), // Button border radius
                          ),
                        ),
                        elevation: MaterialStateProperty.all(
                            0), // Set button elevation to 0
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.black
                                  .withOpacity(0.1); // Change color on hover
                            }
                            return Colors
                                .grey.shade50; // Set default overlay color
                          },
                        ),
                        minimumSize: MaterialStateProperty.all(const Size(
                            1000, 80)), // Adjust the width and height
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 26,
                            height: 26,
                            child: Image.asset(
                              'assets/images/AddNewCouponsIcon.png', // asset icon
                              width: 26,
                              height: 26,
                            ),
                          ),
                          const SizedBox(
                              width:
                              45), // Add some space between the icon and text
                          const Text(
                            'Add New Category',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                              width:51), // Add some space between the icon and text
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
                    SizedBox(height: 15,),

                    //All Categories Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AllCategoryScreen()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Colors.grey.shade100), // Button background color
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8.0), // Button border radius
                          ),
                        ),
                        elevation: MaterialStateProperty.all(
                            0), // Set button elevation to 0
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.black
                                  .withOpacity(0.1); // Change color on hover
                            }
                            return Colors
                                .grey.shade50; // Set default overlay color
                          },
                        ),
                        minimumSize: MaterialStateProperty.all(const Size(
                            1000, 80)), // Adjust the width and height
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 26,
                            height: 26,
                            child: Image.asset(
                              'assets/images/AllCategoriesIcon.png', // asset icon
                              width: 26,
                              height: 26,
                            ),
                          ),
                          const SizedBox(
                              width:
                              45), // Add some space between the icon and text
                          const Text(
                            'All Categories',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                              width: 93), // Add some space between the icon and text
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
                    SizedBox(height: 15,),
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
