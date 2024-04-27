import 'package:flutter/material.dart';
import 'package:project_v/widgets/Layout/adminheaderfooter.dart';

class AdminProfileScreen extends StatefulWidget{
  const AdminProfileScreen({super.key});

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
  }

class _AdminProfileScreenState extends State<AdminProfileScreen>{

  @override
  Widget build(BuildContext context) {
    return AdminHeaderFooter(context: context, body: const Text("Profile"), title: "AdminProfileScreen", buttonStatus: const [false, false, false, false, true]);
  }}

