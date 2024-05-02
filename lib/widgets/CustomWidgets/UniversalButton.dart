import 'package:flutter/material.dart';

class CreateButton extends StatefulWidget {
  const CreateButton(
      {super.key, required this.buttontext, required this.navigator, required this.context});

  final String buttontext;
  // ignore: prefer_typing_uninitialized_variables
  final navigator;
  final BuildContext context;

  @override
  State<CreateButton> createState() => CreateButtonState();
}

class CreateButtonState extends State<CreateButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.navigator,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            widget.buttontext,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontFamily: 'Inter',
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
