import 'package:flutter/material.dart';
import 'package:project_v/widgets/Layout/headerfooter.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    // Note that the header for this page is different. May need to create variant of headerfooter that has tabs 'Completed, 'Cancelled' and 'Active'
    return HeaderFooter(context: context, body: const Text("ABOUT US"), title: "AboutUs", buttonStatus: const [false, false, false, false, true]);
  }
}