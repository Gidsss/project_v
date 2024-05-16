import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // For date formatting
import '../../../widgets/CustomFooterHeaderWidgets/adminfooter.dart';
import '../../../widgets/CustomFooterHeaderWidgets/header2.dart';
import '../../../widgets/CustomWidgets/UniversalButton.dart';

class EditCouponScreen extends StatefulWidget {
  final String couponCode;
  final String description;
  final String benefits;
  final String usageLimit;
  final String status;
  final String startDate;
  final String endDate;
  final String documentId;

  const EditCouponScreen({
    required this.couponCode,
    required this.description,
    required this.benefits,
    required this.usageLimit,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.documentId,
  });

  @override
  _EditCouponScreenState createState() => _EditCouponScreenState();
}

class _EditCouponScreenState extends State<EditCouponScreen> {
  late TextEditingController couponCodeController;
  late TextEditingController descriptionController;
  late TextEditingController benefitsController;
  late TextEditingController usageLimitController;
  late TextEditingController startDateController;
  late TextEditingController endDateController;
  String selectedStatus = 'Available';
  final DateFormat dateFormat = DateFormat('MM/dd/yyyy');

  @override
  void initState() {
    super.initState();
    couponCodeController = TextEditingController(text: widget.couponCode);
    descriptionController = TextEditingController(text: widget.description);
    benefitsController = TextEditingController(text: widget.benefits);
    usageLimitController = TextEditingController(text: widget.usageLimit);
    startDateController = TextEditingController(text: widget.startDate);
    endDateController = TextEditingController(text: widget.endDate);
    selectedStatus = widget.status;
  }

  Future<void> selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = dateFormat.format(picked);
      });
    }
  }

  Future<void> updateCoupon() async {
    String couponCode = couponCodeController.text;
    if (couponCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Coupon code cannot be empty.')));
      return;
    }
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('coupons')
        .where('couponCode', isEqualTo: couponCode)
        .get();
    // Check if there's another document with the same coupon code
    if (result.docs.any((doc) => doc.id != widget.documentId)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('A coupon with this code already exists.')));
      return;
    }

    String description = descriptionController.text;
    int benefits = int.tryParse(benefitsController.text) ?? 0;
    int usageLimit = int.tryParse(usageLimitController.text) ?? 0;
    String startDate = startDateController.text;
    String endDate =
        endDateController.text.isNotEmpty ? endDateController.text : '';

    if (couponCode.isEmpty ||
        description.isEmpty ||
        startDate.isEmpty ||
        usageLimit == 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please fill all required fields with valid data.')));
      return;
    }

    Map<String, dynamic> couponData = {
      'couponCode': couponCode,
      'description': description,
      'benefits': benefits,
      'usageLimit': usageLimit,
      'status': selectedStatus,
      'startDate': startDate,
      'endDate': endDate,
    };

    try {
      await FirebaseFirestore.instance
          .collection('coupons')
          .doc(widget.documentId)
          .update(couponData);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Coupon updated successfully!')));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error updating coupon: $e')));
    }
  }

  Future<void> confirmUpdate(BuildContext context) async {
    return showDialog(
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
                  const Text("Confirm Changes",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(
                      "Are you sure you want to save the changes to ${couponCodeController.text}?",
                      textAlign: TextAlign.center),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.28,
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("No",
                                style: TextStyle(color: Colors.black)),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: ElevatedButton(
                            onPressed: () {
                              updateCoupon();
                              Navigator.pop(context);
                            },
                            child: const Text("Yes",
                                style: TextStyle(color: Colors.black)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header2(text: "Edit Coupon"),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/AllCouponsIcon.png', // Asset icon
                        width: 88,
                        height: 88,
                      ),
                    ),
                    const Text("Coupon Code Name",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    createField(couponCodeController),
                    const Text("Description",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    createField(descriptionController, maxLines: 3),
                    const Text("Benefits",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    createField(benefitsController),
                    const Text("Usage Limit (Optional)",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    createField(usageLimitController),
                    const Text("Status",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    DropdownButtonFormField<String>(
                      value: selectedStatus,
                      items: ['Available', 'Unavailable', 'Expired']
                          .map((status) => DropdownMenuItem(
                              value: status, child: Text(status)))
                          .toList(),
                      onChanged: (value) =>
                          setState(() => selectedStatus = value!),
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 15),
                    const Text("Start Date",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    buildDatePickerField("", startDateController),
                    const Text("End Date (Optional)",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    buildDatePickerField("", endDateController),
                    const SizedBox(height: 15),
                    CreateButton(
                      buttontext: 'Save Changes',
                      navigator: () => confirmUpdate(context),
                      context: context,
                    ),
                    // ElevatedButton(
                    //   onPressed: () => confirmUpdate(context),
                    //   child: const Text("Save Changes"),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          AdminFooter(
              buttonStatus: const [false, false, true, false, false],
              context: context),
        ],
      ),
    );
  }

  Widget createField(TextEditingController controller, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: const InputDecoration(border: OutlineInputBorder()),
      ),
    );
  }

  Widget buildDatePickerField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: GestureDetector(
        onTap: () => selectDate(context, controller),
        child: AbsorbPointer(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: label,
              suffixIcon: const Icon(Icons.calendar_today),
            ),
          ),
        ),
      ),
    );
  }
}
