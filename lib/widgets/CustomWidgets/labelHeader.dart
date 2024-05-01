import 'package:flutter/material.dart';

class LabelHeader extends StatelessWidget {
  const LabelHeader({super.key, required this.text});

  final String text;

  @override
  Widget build(context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        text,
      ),
    );
  }
}
