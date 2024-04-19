import 'package:flutter/material.dart';
import 'package:project_v/widgets/Layout/headerfooter.dart';

class ScheduleScreen extends StatefulWidget{
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
  }

class _ScheduleScreenState extends State<ScheduleScreen>{

  @override
  Widget build(BuildContext context) {
    return HeaderFooter(context: context, body: const Text("Schedule"), title: "Screen", buttonStatus: const [false, false, true, false, false]);
  }}


