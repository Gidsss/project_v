import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/adminHeader.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/adminfooter.dart';
import 'package:project_v/widgets/CustomWidgets/adminfeatureHeader.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          AdminHeader(context: context),
          Expanded(
              child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          createButton(
                              "Add Product", context, Icons.add_circle),
                          createButton("Edit Product", context, Icons.edit)
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      createSearchCategory(context)
                    ],
                  ),
                )
              ],
            ),
          )),
          AdminFooter(
            buttonStatus: [false, true, false, false, false],
            context: context,
          )
        ],
      ),
    );
  }
}

Widget createButton(String text, BuildContext context, IconData icon) {
  return Container(
    decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 3),
          )
        ],
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(5)),
    width: MediaQuery.of(context).size.width * 0.45,
    height: MediaQuery.of(context).size.height * 0.05,
    child: InkWell(
      onTap: () {},
      child: ListTile(
        visualDensity: VisualDensity.compact,
        contentPadding: EdgeInsets.symmetric(horizontal: 15),
        dense: true,
        leading: Icon(
          icon,
          color: Colors.white.withOpacity(0.95),
        ),
        title: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}

Widget createSearchCategory(BuildContext context) {
  return Container(
      decoration: BoxDecoration(
          border: Border.all(),
          color: Colors.white.withOpacity(0.85),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 3),
            )
          ],
          borderRadius: BorderRadius.circular(5)),
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.05,
      child: ListTile(
        visualDensity: VisualDensity.compact,
        minVerticalPadding: 0,
        dense: true,
        leading: Container(
          width: MediaQuery.of(context).size.width * 0.45,
          height: MediaQuery.of(context).size.height * 0.25,
          child: TextFormField(
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 12),
              hintText: "Search Products",
              hintStyle: TextStyle(fontSize: 14),
              border: InputBorder.none,
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
          ),
        ),
        title: InkWell(
          splashColor: Colors.black,
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("All Categories"),
              Icon(Icons.expand_more),
            ],
          ),
        ),
      ));
}
