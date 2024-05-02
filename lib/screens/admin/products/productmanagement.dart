import 'package:flutter/material.dart';
import 'package:project_v/screens/admin/products/addproduct.dart';
import 'package:project_v/screens/admin/products/editproduct.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/adminHeader.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/adminfooter.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen(
      {super.key,
      this.isNavigatedfromAddProd,
      this.setIsNavigatedFromaddProd,
      this.isNavigatedfromDelProd,
      this.setIsNavigatedFromDelProd});
  final bool? isNavigatedfromAddProd;
  final Function(bool)? setIsNavigatedFromaddProd;

  final bool? isNavigatedfromDelProd;
  final Function(bool)? setIsNavigatedFromDelProd;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  bool isEdit = false;

  Widget createSwitchButton() {
    return Switch(
        trackOutlineColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.white.withOpacity(0.1);
            }
            return Colors.white.withOpacity(0.1);
          },
        ),
        thumbColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.white;
            }
            return Colors.white;
          },
        ),
        thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return const Icon(
                Icons.edit,
                color: Colors.black,
              );
            }
            return const Icon(Icons.visibility, color: Colors.black);
          },
        ),
        activeTrackColor: Colors.white.withOpacity(0.15),
        inactiveTrackColor: Colors.white.withOpacity(0.15),
        value: isEdit,
        onChanged: (bool value) {
          setState(() {
            isEdit = value;
          });
        });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.isNavigatedfromAddProd == true) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100)),
                  height: 185, // Set the desired height
                  width: MediaQuery.of(context).size.width *
                      0.67, // Set the desired width
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Product Added",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "ProductName was added successfully to the store's catalog.",
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: ElevatedButton(
                                  style: const ButtonStyle(
                                      elevation: MaterialStatePropertyAll(4),
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.black)),
                                  onPressed: () {
                                    if (widget.setIsNavigatedFromaddProd !=
                                        null) {
                                      widget.setIsNavigatedFromaddProd!(false);
                                    }
                                    Navigator.pop(
                                      context,
                                    );
                                  },
                                  child: const Text(
                                    "Okay",
                                    style: TextStyle(color: Colors.white),
                                  ))),
                        )
                      ],
                    ),
                  )),
            );
          },
        );
      } else if (widget.isNavigatedfromDelProd == true) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100)),
                  height: 185, // Set the desired height
                  width: MediaQuery.of(context).size.width *
                      0.67, // Set the desired width
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Product Deleted",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "ProductName was deleted successfully from the store's catalog.",
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: ElevatedButton(
                                  style: const ButtonStyle(
                                      elevation: MaterialStatePropertyAll(4),
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.black)),
                                  onPressed: () {
                                    if (widget.setIsNavigatedFromDelProd !=
                                        null) {
                                      widget.setIsNavigatedFromDelProd!(false);
                                    }
                                    Navigator.pop(
                                      context,
                                    );
                                  },
                                  child: const Text(
                                    "Okay",
                                    style: TextStyle(color: Colors.white),
                                  ))),
                        )
                      ],
                    ),
                  )),
            );
          },
        );
      }
    });
  }

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
                                "Add Product", context, Icons.add_circle, () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AddProduct()));
                            }),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: MediaQuery.of(context).size.width * 0.1,
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  isEdit
                                      ? const Text(
                                          "Edit Mode",
                                          style: TextStyle(color: Colors.white),
                                        )
                                      : const Text(
                                          "View Mode",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  createSwitchButton()
                                ],
                              ),
                            )
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
                          columnWidths: const {
                            0: FlexColumnWidth(1),
                            1: FlexColumnWidth(2),
                            2: FlexColumnWidth(1),
                            3: FlexColumnWidth(1),
                          },
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: [
                            TableRow(
                              children: [
                                const Align(
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
                                const Align(
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
                                const Align(
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
                                    padding: const EdgeInsets.all(8),
                                    child: isEdit
                                        ? const Text("Edit",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ))
                                        : const Text("Sold",
                                            style: TextStyle(
                                              color: Colors.white,
                                            )),
                                  )),
                                )
                              ],
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(5)),
                                  color: Colors.black.withOpacity(0.9)),
                            ),
                            ...List.generate(
                                15,
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
                                          isEdit
                                              ? TableCell(
                                                  verticalAlignment:
                                                      TableCellVerticalAlignment
                                                          .fill,
                                                  child: InkWell(
                                                    child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.black
                                                              .withOpacity(0.9),
                                                        ),
                                                        child: const Icon(
                                                          Icons.edit,
                                                          color: Colors.white,
                                                        )),
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  EditProduct()));
                                                    },
                                                  ))
                                              : const TableCell(
                                                  child: Padding(
                                                  padding: EdgeInsets.all(8),
                                                  child: Text(
                                                    textAlign: TextAlign.center,
                                                    "150",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ))
                                        ]))
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
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

Widget createButton(
    String text, BuildContext context, IconData icon, void Function() onTap) {
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
      onTap: onTap,
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
        leading: SizedBox(
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
