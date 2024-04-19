import 'package:flutter/material.dart';
import 'package:project_v/widgets/Layout/headerfooter.dart';

class ordersScreen extends StatefulWidget {
  const ordersScreen({super.key});

  @override
  State<ordersScreen> createState() => _ordersScreenState();
}

class _ordersScreenState extends State<ordersScreen> {
  @override
  Widget build(BuildContext context) {
    // Note that the header for this page is different. May need to create variant of headerfooter that has tabs 'Completed, 'Cancelled' and 'Active'
    return HeaderFooter(context: context, body: const Text("Orders"), title: "OrdersScreen", buttonStatus: const [false, false, false, true, false]);
  }
}
