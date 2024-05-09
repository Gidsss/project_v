import 'package:flutter/material.dart';
import 'package:project_v/screens/admin/manage/editcoupons.dart';
import '../../../widgets/CustomFooterHeaderWidgets/adminfooter.dart';
import '../../../widgets/CustomFooterHeaderWidgets/header2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllCouponsScreen extends StatefulWidget {
  const AllCouponsScreen({super.key});

  @override
  State<AllCouponsScreen> createState() => _AllCouponsScreenState();
}

class _AllCouponsScreenState extends State<AllCouponsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header2(text: "All Coupons"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: "Coupons"),
              Tab(text: "Redeems"),
              Tab(text: "Status"),
            ],
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                buildCouponList(), // For the "Coupons" tab
                buildRedeemsList(), // For the "Redeems" tab
                buildStatusList(), // For the "Status" tab
              ],
            ),
          ),
          AdminFooter(
            buttonStatus: const [false, false, true, false, false],
            context: context,
          )
        ],
      ),
    );
  }

  // Coupons tab content dynamically from Firestore
  Widget buildCouponList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('coupons').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No coupons available.'));
        }

        return ListView(
          padding:
              const EdgeInsets.all(4.0), // Optional padding for the whole list
          children: snapshot.data!.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            String couponCode = data['couponCode'] ?? 'No Code';
            String benefits = data['benefits'] ?? '';
            String usageLimit = data['usageLimit'] != null
                ? data['usageLimit'].toString()
                : '---';
            String status = data['status'] ?? 'Unknown';
            String documentId = doc.id;

            return Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 4.0), // Adds spacing between each card
              child: Card(
                child: ListTile(
                  leading: const Padding(
                    padding: EdgeInsets.only(
                        right: 24.0, top: 24.0), // Adjust as needed
                    child: SizedBox(
                      width: 10, // Adjust the width as needed
                      height: 75, // Adjust the height as needed
                      child: Icon(
                        Icons.local_offer,
                        color: Colors.black,
                        size: 35, // Adjust the size as needed
                      ),
                    ),
                  ),
                  title: Text(
                    "$couponCode | $benefits",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Usage Limit: $usageLimit           Status: $status",
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 13),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          "Start Date: ${data['startDate'] ?? '---'}",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                      Text(
                        "End Date: ${data['endDate'] ?? '---'}",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  isThreeLine: true,
                  onTap: () {
                    // Navigate to the edit screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditCouponScreen(
                          couponCode: couponCode,
                          description: data['description'] ?? '',
                          benefits: benefits,
                          usageLimit: usageLimit,
                          status: status,
                          startDate: data['startDate'] ?? '',
                          endDate: data['endDate'] ?? '',
                          documentId: documentId,
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget buildRedeemsList() {
    return ListView(
      children: const [
        ListTile(
          title: Text("SUMMER GLASS"),
          subtitle: Text("SUMMER Discount\nUsage Limit: 100"),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        // Add more ListTiles or custom widgets as needed
      ],
    );
  }

  Widget buildStatusList() {
    return ListView(
      children: const [
        ListTile(
          title: Text("20240130YTK2"),
          subtitle: Text("10% Discount\nStatus: Available"),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        // Add more ListTiles or custom widgets as needed
      ],
    );
  }
}
