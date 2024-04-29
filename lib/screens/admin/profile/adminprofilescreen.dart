import 'package:flutter/material.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/adminHeader.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/adminfooter.dart';

class AdminProfileScreen extends StatefulWidget{
  const AdminProfileScreen({super.key});

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
  }

class _AdminProfileScreenState extends State<AdminProfileScreen>{

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        AdminHeader(context: context),
        Expanded(
          child: Text("Profile"),
        ),
        AdminFooter(
            buttonStatus: [false, false, false, false, true], context: context)
      ],
    ));
  }}

