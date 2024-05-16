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
            String benefits = data['benefits'] != null ? '${data['benefits']}%' : '---';
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
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('coupons').snapshots(),
    builder: (context, snapshot) {
      // Show a progress indicator if data is still loading
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.black)));
      }

      // Show a message if no data is available
      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        return const Center(child: Text("No coupons available."));
      }

      // Data is available, so we show the table
      return Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16), // Adjust padding as needed
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(1),
            3: FlexColumnWidth(1),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          border: TableBorder.all(color: Colors.grey.withOpacity(0.2)), // Optional: add border for better definition
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.9)),
              children: const [
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text("Code", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.only(left: 48),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text("Benefits", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.only(left: 22),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text("Limit", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text("Redeems", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
            ...snapshot.data!.docs.map((doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              String couponCode = data['couponCode'] ?? 'No Code';
              String benefits = data['benefits'] != null ? '${data['benefits']}%' : '---';
              String usageLimit = data['usageLimit'] != null ? data['usageLimit'].toString() : '---';
              String redeems = data['redeems'] != null ? data['redeems'].toString() : '0'; // Default to '0' if not available

              return TableRow(
                decoration: BoxDecoration(border: Border.all(color: Colors.grey.withOpacity(0.2))),
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(couponCode, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(benefits, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(usageLimit, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(redeems, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              );
            }).toList(),
          ],
        ),
      );
    },
  );
}


  Widget buildStatusList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('coupons').snapshots(),
      builder: (context, snapshot) {
        // Show a progress indicator if data is still loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.black)));
        }

        // Show a message if no data is available
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No coupons available."));
        }
        return Padding(
            padding: const EdgeInsets.only(
                top: 16, left: 16, right: 16), // Adjust padding as needed
            // Data is available, so we show the table
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: TableBorder.all(
                  color: Colors.grey.withOpacity(
                      0.2)), // Optional: add border for better definition
              children: [
                TableRow(
                  children: const [
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text("Code",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.only(left: 48),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text("Benefits",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.only(left: 22),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text("Limit",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text("Status",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                  ],
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.9)),
                ),
                ...snapshot.data!.docs.map((doc) {
                  Map<String, dynamic> data =
                      doc.data() as Map<String, dynamic>;
                  String couponCode = data['couponCode'] ?? 'No Code';
                   String benefits = data['benefits'] != null ? '${data['benefits']}%' : '---';
                  String usageLimit = data['usageLimit'] != null
                      ? data['usageLimit'].toString()
                      : '---';
                  String status = data['status'] ?? 'Unknown';

                  return TableRow(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey.withOpacity(0.2))),
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(couponCode,
                              textAlign: TextAlign.center,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600)),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(benefits,
                              textAlign: TextAlign.center,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600)),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text(usageLimit,
                              textAlign: TextAlign.center,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600)),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text(status,
                              textAlign: TextAlign.center,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ],
            ));
      },
    );
  }
}
