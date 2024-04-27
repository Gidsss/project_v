import 'package:flutter/material.dart';
import 'package:project_v/widgets/Layout/adminheaderfooter.dart';

class CouponsScreen extends StatefulWidget{
  const CouponsScreen({super.key});

  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
  }

class _CouponsScreenState extends State<CouponsScreen>{

  @override
  Widget build(BuildContext context) {
    return AdminHeaderFooter(context: context, body: const Text("Coupons"), title: "CouponsScreen", buttonStatus: const [false, false, true, false, false]);
  }}

