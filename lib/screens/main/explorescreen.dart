import 'package:flutter/material.dart';
import 'package:project_v/widgets/Layout/headerfooter.dart';

class ExploreScreen extends StatefulWidget{
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
  }

class _ExploreScreenState extends State<ExploreScreen>{

  @override
  Widget build(BuildContext context) {
    return HeaderFooter(context: context, body: const Text("Explore"), title: "ExploreScreen", buttonStatus: const [false, true, false, false, false]);
  }}


