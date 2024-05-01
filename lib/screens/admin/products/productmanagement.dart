import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_v/constants/app_constants.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/adminHeader.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/adminfooter.dart';

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
              child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  const SizedBox(
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
                        const SizedBox(
                          height: 10,
                        ),
                        createSearchCategory(context),
                        const SizedBox(
                          height: 15,
                        ),
                        Table(
                          columnWidths: {
                            0: const FlexColumnWidth(1),
                            1: const FlexColumnWidth(2),
                            2: const FlexColumnWidth(1),
                            3: const FlexColumnWidth(1),
                          },
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: [
                            TableRow(
                              children: const [
                                Align(
                                  alignment: Alignment.center,
                                  child: TableCell(
                                      child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text("Image",
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                  )),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: TableCell(
                                      child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text("Name",
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                  )),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: TableCell(
                                      child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text("Stock",
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                  )),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: TableCell(
                                      child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text("Sold",
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                  )),
                                ),
                              ],
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(5)),
                                  color: Colors.black.withOpacity(0.9)),
                            ),
                            ...List.generate(
                                30,
                                (index) => TableRow(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey
                                                    .withOpacity(0.2))),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: TableCell(
                                                child: Image.asset(
                                              "assets/images/product_1.jpg",
                                              fit: BoxFit.fitHeight,
                                            )),
                                          ),
                                          const TableCell(
                                              child: Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              "Grandeur De Chalamaetere",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          )),
                                          const TableCell(
                                              child: Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              "10",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          )),
                                          const TableCell(
                                              child: Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              "150",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          )),
                                        ]))
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          )),
          AdminFooter(
            buttonStatus: const [false, true, false, false, false],
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
            offset: const Offset(0, 3),
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        dense: true,
        leading: Icon(
          icon,
          color: Colors.white.withOpacity(0.95),
        ),
        title: Text(
          text,
          style: const TextStyle(color: Colors.white),
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
              offset: const Offset(0, 3),
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
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
            decoration: const InputDecoration(
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
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("All Categories"),
              Icon(Icons.expand_more),
            ],
          ),
        ),
      ));
}
