import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_v/screens/admin/orders/vieweditorder.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/adminHeader.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/adminfooter.dart';

class OrdersMadeScreen extends StatefulWidget {
  const OrdersMadeScreen({super.key});

  @override
  State<OrdersMadeScreen> createState() => _OrdersMadeScreenState();
}

class _OrdersMadeScreenState extends State<OrdersMadeScreen> {

  String getCurrentDateWithTime() {
    DateTime now = DateTime.now();
    String formattedDate = '${now.day}, ${now.month}, ${now.year} at ${now.hour}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12? 'P.M.' : 'A.M.'}';
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Column(
        children: [
          AdminHeader(context: context),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: double.infinity,
                    color: Colors.black,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(8, 15, 8, 15),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Date and Time',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            getCurrentDateWithTime(),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          Divider(
                            color: Colors.white,
                            height: 20,
                            thickness: 1,
                          ),
                          StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('orders')
                                .snapshots(),
                            builder: (context, snapshot) {
                              // Show a progress indicator if data is still loading
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation(
                                      Colors.black,
                                    ),
                                  ),
                                );
                              }
                              // Show a message if no data is available
                              if (!snapshot.hasData ||
                                  snapshot.data!.docs.isEmpty) {
                                return const Center(
                                  child: Text("No Orders available."),
                                );
                              }
                              int totalCount = snapshot.data!.docs.length;
                              return Column(
                                children: [
                                  Text(
                                    'Total Orders',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '$totalCount', // Displaying the total count as a string
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),

                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                      height: 10
                  ),
                  createSearchCategory(context),
                  const SizedBox(
                      height: 10
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('orders')
                          .snapshots(),
                      builder: (context, snapshot) {
                        // Show a progress indicator if data is still loading
                        if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator( valueColor: AlwaysStoppedAnimation(
                                  Colors.black),));
                        }
                        // Show a message if no data is available
                        if (!snapshot.hasData ||
                            snapshot.data!.docs.isEmpty) {
                          return const Center(
                              child: Text("No Orders available."));
                        }
                        int totalCount = snapshot.data!.docs.length;
                        return Table(
                          columnWidths: const {
                            0: FlexColumnWidth(1.5),
                            1: FlexColumnWidth(1.5),
                            2: FlexColumnWidth(1),
                          },
                          defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                          children: [
                            TableRow(
                              children: const [
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                    left: 20,
                                      top: 10,
                                      bottom: 10,
                                    ),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Order Tracking ID",
                                        style: TextStyle(
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 55,
                                      top: 10,
                                      bottom: 10,
                                    ),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Status",
                                        style: TextStyle(
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left:5,
                                      top: 10,
                                      bottom: 10,
                                    ),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "View/Edit",
                                        style: TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.9)
                              ),
                            ),
                            ...snapshot.data!.docs.map((doc) {
                              Map<String, dynamic> data =
                              doc.data() as Map<String, dynamic>;
                              String statusText = data['IsActive'] ? "ACTIVE" : "COMPLETED";
                              return TableRow(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey
                                            .withOpacity(0.2))),
                                children: [
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(doc['TrackingID'],
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontWeight:
                                              FontWeight.w600)),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                          statusText,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontWeight:
                                              FontWeight.w600)),
                                    ),
                                  ),
                                  TableCell(
                                    verticalAlignment: TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 8,
                                        bottom: 8,
                                        right: 40,
                                        left: 15,
                                      ),
                                      child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: IconButton(
                                              iconSize: 30,
                                              color: Colors.white,
                                              onPressed: (){
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewEditOrder(orderData: doc.data())));
                                              },
                                              icon: const Icon(Icons.remove_red_eye_outlined),
                                            ),
                                          )
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ],
                        );
                      },
                  ),
                ],
              ),
            ),
          ),
          AdminFooter(buttonStatus: const [false, false, false, true, false], context: context)
        ],
        )
    );
  }
}


Widget createSearchCategory(BuildContext context) {
  return Container(
      decoration: BoxDecoration(
          border: Border.all(),
          color: Colors.white.withOpacity(0.85),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 3),
            )
          ],
          borderRadius: BorderRadius.circular(5)),
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.05,
      child: ListTile(
        visualDensity: VisualDensity.compact,
        minVerticalPadding: 0,
        dense: true,
        leading: SizedBox(
          width: MediaQuery.of(context).size.width * 0.45,
          height: MediaQuery.of(context).size.height * 0.25,
          child: TextFormField(
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 12),
              hintText: "Search Orders",
              hintStyle: TextStyle(fontSize: 14),
              border: InputBorder.none,
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
          ),
        ),
        title: InkWell(
          splashColor: Colors.black,
          onTap: () {},
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("All Orders"),
              Icon(Icons.expand_more),
            ],
          ),
        ),
      )
  );
}
