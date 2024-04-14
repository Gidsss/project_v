import 'package:flutter/material.dart';
import 'package:project_v/widgets/Layout/headerfooter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HeaderFooter(
        title: "HeaderFooter",
        buttonStatus : [true, false, false, false, false],
        body: SingleChildScrollView(child: Column(
          children: [
            Text("adadadada"),
          ],
        ),));
  }
}
