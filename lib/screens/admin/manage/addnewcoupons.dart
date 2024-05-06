import 'package:flutter/material.dart';
import '../../../widgets/CustomFooterHeaderWidgets/adminfooter.dart';
import '../../../widgets/CustomFooterHeaderWidgets/header2.dart';

class AddNewCouponsScreen extends StatefulWidget {
  const AddNewCouponsScreen({super.key});

  @override
  State<AddNewCouponsScreen> createState() => _AddNewCouponsScreenState();
}

class _AddNewCouponsScreenState extends State<AddNewCouponsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header2(text: "Add New Coupon"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(

            ),
          ),
          AdminFooter(
              buttonStatus: const [false, false, true, false, false],
              context: context)
        ],
      ),
    );
  }
}
