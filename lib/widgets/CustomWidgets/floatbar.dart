import 'package:flutter/material.dart';

class createFloatbar extends StatelessWidget {
  const createFloatbar(
      {super.key, required this.text, required this.navigator});
  final Function navigator;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 90.0, left: 30, right: 30),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  fixedSize:
                      MaterialStateProperty.all<Size>(const Size(185, 45))),
              onPressed: () {
                navigator();
              },
              child: Text(
                text,
                style: const TextStyle(fontWeight: FontWeight.normal),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
