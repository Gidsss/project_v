
import 'package:flutter/material.dart';
import 'package:project_v/screens/admin/products/productmanagement.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/adminfooter.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/header2.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:project_v/widgets/CustomWidgets/UniversalButton.dart';

enum ColorLabel {
  blue('Blue', Colors.blue),
  pink('Pink', Colors.pink),
  green('Green', Colors.green),
  yellow('Orange', Colors.orange),
  grey('Grey', Colors.grey),
  black('Black', Colors.black);

  const ColorLabel(this.label, this.color);
  final String label;
  final Color color;
} // Should match the colors in categories.

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => AddProductState();
}

class AddProductState extends State<AddProduct> {
  bool exists = false;
  bool? isChecked;
  final TextEditingController colorController = TextEditingController();
  ColorLabel? selectedColor;

  Widget createColorDropdown() {
    return Row(
      children: [
        DropdownMenu<ColorLabel>(
            textStyle:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            width: MediaQuery.of(context).size.width * 0.45,
            inputDecorationTheme: const InputDecorationTheme(
                hintStyle: TextStyle(fontSize: 14, height: 1),
                constraints: BoxConstraints.tightFor(
                  height: 40,
                ),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(8)),
            menuHeight: 300,
            trailingIcon: Transform.translate(
              offset: const Offset(1, -6),
              child: const Icon(Icons.arrow_drop_down),
            ),
            hintText: "Pick a color",
            initialSelection: null,
            controller: colorController,
            requestFocusOnTap: true,
            onSelected: (ColorLabel? color) {
              setState(() {
                selectedColor = color;
              });
            },
            dropdownMenuEntries: ColorLabel.values
                .map<DropdownMenuEntry<ColorLabel>>((ColorLabel color) {
              return DropdownMenuEntry<ColorLabel>(
                value: color,
                label: color.label,
              );
            }).toList())
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const Header2(text: "Add Product"),
        body: Column(children: [
          Expanded(
              child: SingleChildScrollView(
            child: Container(
                child: Column(children: [
              const SizedBox(
                height: 20,
              ),
              CarouselSlider(
                options: CarouselOptions(
                    initialPage: 1,
                    enableInfiniteScroll: false,
                    viewportFraction: 0.5,
                    height: MediaQuery.of(context).size.height * 0.30,
                    enlargeCenterPage: true),
                items: [
                  createSliderItem(context),
                  createSliderItem(context),
                  createSliderItem(context)
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Product Name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    createField(MediaQuery.of(context).size.width * 1, 0,
                        "Galataire", 1, 1, false),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Product Description",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    createField(MediaQuery.of(context).size.width * 1, 40,
                        "Description", 5, null, false),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Product Price",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    createField(MediaQuery.of(context).size.width * 1, 0,
                        "₱ 6,000", 1, 1, true),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Product Color",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            createColorDropdown(),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Product Quantity",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            createField(
                                MediaQuery.of(context).size.width * 0.45,
                                0,
                                "15",
                                1,
                                1,
                                false),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Has a Grade Selection?",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    RadioListTile(
                        contentPadding: EdgeInsets.zero,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        splashRadius: 15,
                        fillColor: const MaterialStatePropertyAll(Colors.black),
                        visualDensity: const VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity),
                        dense: true,
                        title: const Text("No"),
                        value: true,
                        groupValue: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        }),
                    RadioListTile(
                        contentPadding: EdgeInsets.zero,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        splashRadius: 15,
                        fillColor: const MaterialStatePropertyAll(Colors.black),
                        visualDensity: const VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity),
                        dense: true,
                        title: const Text("Yes"),
                        value: false,
                        groupValue: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    // Should probably validate the inputs, before allowing a navpush
                    CreateButton(
                        buttontext: "Add Product",
                        navigator: () {
                          showaddProductDialog(context);
                        },
                        context: context),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ])),
          )),
          AdminFooter(
              buttonStatus: const [false, true, false, false, false],
              context: context)
        ]));
  }
}

Widget createSliderItem(BuildContext context) {
  return Stack(children: [
    Container(
      width: MediaQuery.of(context).size.width * 0.50,
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              offset: const Offset(2, 2),
              blurRadius: 3,
              spreadRadius: 2)
        ],
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
            image: AssetImage("assets/images/product_1.jpg"),
            fit: BoxFit.contain),
      ),
    ),
    IconButton(
        onPressed: () {},
        tooltip: "Add more Images",
        icon: const Icon(
          Icons.add_circle,
          color: Colors.black,
          size: 30,
        ))
  ]);
}

Widget createField(double width, double height, String text, int? minlines,
    int? maxlines, bool currency) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
    ),
    height: 40 + height,
    width: width,
    child: TextFormField(
      minLines: minlines,
      maxLines: maxlines,
      style: const TextStyle(fontSize: 14, height: 1),
      onSaved: (String? value) {},
      validator: (value) {
        return null;
      },
      decoration: InputDecoration(
          prefixText: currency ? "₱ " : null,
          border: const OutlineInputBorder(),
          hintText: text,
          hintStyle: const TextStyle(fontSize: 14, height: 1),
          contentPadding: const EdgeInsets.fromLTRB(8, 10, 8, 10)),
    ),
  );
}


Future<void> showaddProductDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
          height: 185, // Set the desired height
          width: MediaQuery.of(context).size.width *
              0.67, // Set the desired width
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Add Product?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Are you sure you want to add productName?",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.28,
                        child: ElevatedButton(
                          style: const ButtonStyle(
                            elevation: MaterialStatePropertyAll(4),
                            backgroundColor: MaterialStatePropertyAll(Colors.white),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "No",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: ElevatedButton(
                          style: const ButtonStyle(
                            elevation: MaterialStatePropertyAll(4),
                            backgroundColor: MaterialStatePropertyAll(Colors.black),
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductsScreen(isNavigatedfromAddProd: true,)));
                          },
                          child: const Text(
                            "Yes",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}