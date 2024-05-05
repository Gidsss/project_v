import 'package:flutter/material.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/adminHeader.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/adminfooter.dart';

class OrdersMadeScreen extends StatefulWidget {
  const OrdersMadeScreen({super.key});

  @override
  State<OrdersMadeScreen> createState() => _OrdersMadeScreenState();
}

class _OrdersMadeScreenState extends State<OrdersMadeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        AdminHeader(context: context),
        const Expanded(
          child: Text("Orders Made"),
        ),
        AdminFooter(
            buttonStatus: const [false, false, false, true, false], context: context)
      ],
    ));
  }
}
