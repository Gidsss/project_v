import 'package:flutter/material.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/adminHeader.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/adminfooter.dart';

class ManagementScreen extends StatefulWidget{
  const ManagementScreen({super.key});

  @override
  State<ManagementScreen> createState() => _ManagementScreenState();
  }

class _ManagementScreenState extends State<ManagementScreen>{

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        AdminHeader(context: context),
        const Expanded(
          child: Text("Management"),
        ),
        AdminFooter(
            buttonStatus: const [false, false, true, false, false], context: context)
      ],
    ));
  }}

