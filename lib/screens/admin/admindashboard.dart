import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_v/widgets/CustomWidgets/adminfeatureHeader.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/adminHeader.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/adminfooter.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class DashboardCard extends StatelessWidget {
  final String title;
  final int value;
  final IconData icon;
  final double change;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.change,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      margin: const EdgeInsets.all(8.0),
      color: Colors.white, // White background color for the card
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(icon),
                Text('$value'),
                // Include direction-aware icon
                Icon(change >= 0 ? Icons.trending_up : Icons.trending_down),
                Text('${change.toStringAsFixed(2)}%'),
              ],
            ),
            // You can add a placeholder for your chart/graph here
            // For example, using a Container with a predefined height
          ],
        ),
      ),
    );
  }
}

class DashboardBox extends StatelessWidget {
  final String title;
  final int value;
  final IconData icon;
  final double change;

  const DashboardBox({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.change,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      margin: const EdgeInsets.all(8.0),
      color: Colors.white, // White background color for the card
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Larger padding
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal), // Larger text
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(icon, size: 30.0), // Larger icon
                Text('$value',
                    style: const TextStyle(fontSize: 20.0)), // Larger text
                Icon(change >= 0 ? Icons.trending_up : Icons.trending_down,
                    size: 30.0), // Larger icon
                Text('${change.toStringAsFixed(2)}%',
                    style: const TextStyle(fontSize: 20.0)), // Larger text
              ],
            ),
            const SizedBox(height: 20.0),
            Container(
              height: 140, // Larger fixed height for placeholder
              color: Colors.grey[200], // Slightly darker grey
              width: double.infinity,
              child: const Center(
                  child: Text('Bigger Chart Placeholder',
                      style: TextStyle(fontSize: 18.0))),
            ),
          ],
        ),
      ),
    );
  }
}

//Add another class for two big cards

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  // example data
  final int _numberOfOrders = 20;
  final int _numberOfUsers = 150;
  final int _numberOfSales = 300;
  final int _numberOfNewUsers = 50;

  @override
  Widget build(BuildContext context) {
    // Size calculation variables
    //  var screenSize = MediaQuery.of(context).size;
    double crossAxisSpacing = 4;
    double mainAxisSpacing = 4;
    // double screenWidth = screenSize.width;
    //double cardWidth =   (screenWidth - crossAxisSpacing) / 2; // two cards per row

    return Scaffold(
      body: Column(
        children: [
          AdminHeader(context: context),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AdminFeatureHeader(text:"Admin Dashboard"),
                  Wrap(
                    spacing: crossAxisSpacing, // horizontal space between cards
                    runSpacing: mainAxisSpacing, // vertical space between cards
                    children: [
                      SizedBox(
                          width: 200,
                          height: 120, // Specify the desired width
                          child: DashboardCard(
                            title: 'Orders',
                            value: _numberOfOrders,
                            icon: Icons.shopping_cart,
                            change: 15.34,
                          )),
                      SizedBox(
                        width: 200,
                        height: 120,
                        child: DashboardCard(
                          title: 'Users',
                          value: _numberOfUsers,
                          icon: Icons.people,
                          change: 10.25,
                        ),
                      ),
                      SizedBox(
                        width: 400,
                        height: 320,
                        child: DashboardBox(
                          title: 'Sales',
                          value: _numberOfSales,
                          icon: Icons.attach_money,
                          change: 10.25,
                        ),
                      ),
                      SizedBox(
                        width: 400,
                        height: 320,
                        child: DashboardBox(
                          title: 'New Users',
                          value: _numberOfNewUsers,
                          icon: Icons.person_add,
                          change: 10.25,
                        ),
                      ),
                      // Add more DashboardCard widgets as needed
                    ],
                  ),
                ],
              ),
            ),
          ),
          AdminFooter(
              buttonStatus: [true, false, false, false, false],
              context: context)
        ],
      ),
    );
  }
}
