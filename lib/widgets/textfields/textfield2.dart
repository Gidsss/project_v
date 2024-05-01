// Textfield used in bookingscreensteptwo and add product.

import 'package:flutter/material.dart';

class createtextField2 extends StatelessWidget{
const createtextField2({super.key, this.width, required this.text, required this.context});

final double? width;
final String text;
final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: Colors.grey.withOpacity(0.12),
    ),
    height: 35,
    width: width,
    child: TextFormField(
      style: const TextStyle(fontSize: 14, height: 1),
      onSaved: (String? value) {},
      validator: (value) {
        return null;
      },
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: text,
          hintStyle: const TextStyle(fontSize: 14, height: 1),
          contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 10)),
    ),
  );
  }

}
