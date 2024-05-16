import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // For date formatting
import '../../../widgets/CustomFooterHeaderWidgets/adminfooter.dart';
import '../../../widgets/CustomFooterHeaderWidgets/header2.dart';
import '../../../widgets/CustomWidgets/UniversalButton.dart';

class AddNewCouponsScreen extends StatefulWidget {
  const AddNewCouponsScreen({super.key});

  @override
  State<AddNewCouponsScreen> createState() => _AddNewCouponsScreenState();
}

class _AddNewCouponsScreenState extends State<AddNewCouponsScreen> {
  final TextEditingController couponCodeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController benefitsController = TextEditingController();
  final TextEditingController usageLimitController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  String selectedStatus = 'Available';
  final DateFormat dateFormat = DateFormat('MM/dd/yyyy');

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

  Future<void> addCoupon() async {
    String couponCode = couponCodeController.text;
    if (couponCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Coupon code cannot be empty.')));
      return;
    }

    // Check if the coupon code already exists in the database
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('coupons')
        .where('couponCode', isEqualTo: couponCode)
        .limit(1)
        .get();

    if (result.docs.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('A coupon with this code already exists.')));
      return;
    }
    String description = descriptionController.text;
    int benefits =
        int.tryParse(benefitsController.text) ?? 0; // This now uses int
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

    // Prepare the data to be stored in Firestore
    Map<String, dynamic> couponData = {
      'couponCode': couponCode,
      'description': description,
      'benefits': benefits, // Store as an integer
      'usageLimit': usageLimit,
      'status': selectedStatus,
      'startDate': startDate,
      'endDate': endDate,
    };

    try {
      await FirebaseFirestore.instance.collection('coupons').add(couponData);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Coupon added successfully!')));
      // Navigate back to the previous screen
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error adding coupon: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header2(text: "Add New Coupon"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    const Text(
                      "Coupon Code Name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    createField("", couponCodeController),
                    const Text(
                      "Description",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    createField("", descriptionController, maxLines: 3),
                    const Text(
                      "Benefits",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    createField("", benefitsController,
                        keyboardType: TextInputType.number),
                    const Text(
                      "Usage Limit (Optional)",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    createField("", usageLimitController),
                    const Text(
                      "Status",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    DropdownButtonFormField<String>(
                      value: selectedStatus,
                      items: ['Available', 'Unavailable']
                          .map((status) => DropdownMenuItem(
                                value: status,
                                child: Text(status),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedStatus = value!;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '',
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Start Date",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    buildDatePickerField("", startDateController),
                    const Text(
                      "End Date (Optional)",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    buildDatePickerField("", endDateController),
                    const SizedBox(height: 15),
                    CreateButton(
                      buttontext: 'Add Coupon',
                      navigator: addCoupon,
                      context: context,
                    ),
                  ],
                ),
              ),
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

  Widget createField(String label, TextEditingController controller,
      {int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType, // Add this line
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
        ),
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
