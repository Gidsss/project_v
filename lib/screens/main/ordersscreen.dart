import 'package:flutter/material.dart';
import 'package:project_v/widgets/Layout/headerfooter.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    // Note that the header for this page is different. May need to create variant of headerfooter that has tabs 'Completed, 'Cancelled' and 'Active'
    return HeaderFooter(context: context, body: const Text("Orders"), title: "OrdersScreen", buttonStatus: const [false, false, false, true, false]);
  }
}
