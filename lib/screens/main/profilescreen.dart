import 'package:flutter/material.dart';
import 'package:project_v/widgets/Layout/headerfooter.dart';

class ProfileScreen extends StatefulWidget{
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
  }

class _ProfileScreenState extends State<ProfileScreen>{

  @override
  Widget build(BuildContext context) {
   return HeaderFooter(context: context, body: const Text("Profile"), title: "ProfileScreen", buttonStatus: const [false, false, false, false, true]);
  }}


