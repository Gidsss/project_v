import 'package:flutter/material.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/adminHeader.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/adminfooter.dart';

class CouponsScreen extends StatefulWidget{
  const CouponsScreen({super.key});

  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
  }

class _CouponsScreenState extends State<CouponsScreen>{

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        AdminHeader(context: context),
        const Expanded(
          child: Text("Coupons"),
        ),
        AdminFooter(
            buttonStatus: const [false, false, true, false, false], context: context)
      ],
    ));
  }}

