import 'package:flutter/material.dart';
import 'package:project_v/widgets/Layout/adminheaderfooter.dart';

class CalendarScreen extends StatefulWidget{
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
  }

class _CalendarScreenState extends State<CalendarScreen>{

  @override
  Widget build(BuildContext context) {
    return AdminHeaderFooter(context: context, body: const Text("Calendar"), title: "CalendarScreen", buttonStatus: const [false, false, false, true, false]);
  }}

