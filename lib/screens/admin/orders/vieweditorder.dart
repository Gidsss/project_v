import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:project_v/screens/admin/orders/ordersmadescreen.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/header2.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/adminfooter.dart';

class ViewEditOrder extends StatefulWidget {
  const ViewEditOrder({Key? key});

  @override
  State<ViewEditOrder> createState() => _ViewEditOrderState();
}

class _ViewEditOrderState extends State<ViewEditOrder> {
  String _selectedStatus = 'COMPLETED';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const Header2(text: "View/Edit Order"),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  CarouselSlider(
                    items: [1, 2, 3].map((i) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Image $i',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 40,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: 200,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Customer Name",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 30,
                          child: const TextField(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Inter',
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black), // Border color
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Product Name",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 30,
                          child: const TextField(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Inter',
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black), // Border color
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Tracking ID",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 30,
                          child: const TextField(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Inter',
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black), // Border color
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Status",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 30,
                          child: SizedBox(
                            width: double.infinity,
                            child: InputDecorator(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _selectedStatus,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedStatus = newValue!;
                                    });
                                  },
                                  items: <String>[
                                    'PLACED',
                                    'PROCESSING',
                                    'PREPARING',
                                    'SHIPPING',
                                    'READY FOR PICK-UP',
                                    'COMPLETED'
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(value),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1.3),
                      1: FlexColumnWidth(1.5),
                      2: FlexColumnWidth(1.5),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
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
                                  "Order Status",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
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
                                  "Actual Time",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
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
                                  "Expected Time",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.9),
                        ),
                      ),
                      TableRow(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.2)),
                        ),
                        children: const [
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'PLACED',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '09/09/2024 - 10:10 P.M',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '09/09/2024 - 10:10 P.M',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.2)),
                        ),
                        children: const [
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'PROCESSING',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '09/09/2024 - 10:10 P.M',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '09/09/2024 - 10:10 P.M',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.2)),
                        ),
                        children: const [
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'PREPARING',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '09/09/2024 - 10:10 P.M',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '09/09/2024 - 10:10 P.M',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.2)),
                        ),
                        children: const [
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'SHIPPING',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '09/09/2024 - 10:10 P.M',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '09/09/2024 - 10:10 P.M',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.2)),
                        ),
                        children: const [
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'READY FOR PICK-UP',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '09/09/2024 - 10:10 P.M',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '09/09/2024 - 10:10 P.M',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.2)),
                        ),
                        children: const [
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'COMPLETED',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '09/09/2024 - 10:10 P.M',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '09/09/2024 - 10:10 P.M',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                        fixedSize: MaterialStateProperty.all<Size>(
                            const Size(250, 35)),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Confirmation"),
                              content: const Text(
                                  "Are you sure you want to save changes?"),
                              actions: [
                                TextButton(
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    fixedSize: MaterialStateProperty.all<Size>(
                                        const Size(100, 35)),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Cancel"),
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black),
                                    fixedSize: MaterialStateProperty.all<Size>(
                                        const Size(100, 35)),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const OrdersMadeScreen()));
                                  },
                                  child: const Text("Change"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text("Save Change"),
                    ),
                  )
                ],
              ),
            ),
          ),
          AdminFooter(
            buttonStatus: const [false, false, false, false, true],
            context: context,
          ),
        ],
      ),
    );
  }
}

Widget createButton(BuildContext context, String text) {
  return Center(
    child: ElevatedButton(
      onPressed: () {
        _showMarkDialog(context);
      },
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(Colors.black), // Button background color
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0), // Button border radius
          ),
        ),
        elevation: MaterialStateProperty.all(0), // Set button elevation to 0
        overlayColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.grey; // Change color on pressed
            }
            return Colors.black; // Set default overlay color
          },
        ),
        minimumSize: MaterialStatePropertyAll(Size(
            MediaQuery.of(context).size.width * 0.95,
            MediaQuery.of(context).size.height *
                0.06)), // Adjust the width and height
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: "Inter",
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

void _showMarkDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          height: 185,
          width: MediaQuery.of(context).size.width * 0.67,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Mark as Completed",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Are you sure you want to mark this order as completed?",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.28,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("No",
                            style: TextStyle(color: Colors.black)),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(4),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                        ),
                        onPressed: () async {
                          // Call a function to save the changes
                          await markAsCompleted();
                          Navigator.pop(context);
                        },
                        child: const Text("Yes",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future<void> markAsCompleted() async {
  // Your logic to mark the order as completed
}
