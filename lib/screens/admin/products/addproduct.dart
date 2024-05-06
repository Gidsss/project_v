import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
//import 'package:project_v/screens/admin/products/productmanagement.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/adminfooter.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/header2.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:project_v/widgets/CustomWidgets/UniversalButton.dart';
import 'package:image_picker/image_picker.dart';

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
  final ImagePicker picker = ImagePicker();
  List<File?> imageFiles = List.filled(3, null);
  List<String> imageUrls = [];

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final productModelNumberController = TextEditingController();
  final productColorController = TextEditingController();
  final productQuantityController = TextEditingController();
  final descriptionController = TextEditingController();
  final productGradeController = TextEditingController();

  // Function to handle image selection
  Future<void> pickImage(int index) async {
    try {
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          imageFiles[index] =
              File(pickedFile.path); // Update specific index in the list
          print("Image picked at index $index: ${imageFiles[index]?.path}");
        });
      }
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> addProduct() async {
    if (imageUrls.isNotEmpty &&
        nameController.text.isNotEmpty &&
        priceController.text.isNotEmpty) {
      try {
        // Add product details to Firestore with image URLs
        await FirebaseFirestore.instance.collection('products').add({
          'name': nameController.text,
          'price': priceController.text,
          'description': descriptionController.text,
          'productColor': productColorController.text,
          'productModelNumber': productModelNumberController.text,
          'productQuantity': productQuantityController.text,
          'productGrade': productGradeController.text,
          'imageUrls': imageUrls,
        });

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error adding product: $e')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please fill all fields and pick images')));
    }
  }

  // Function to upload images and get their URLs
  Future<void> uploadImagesAndGetUrls() async {
    imageUrls.clear(); // Clear existing URLs to handle re-uploads
    print("Starting image upload for ${imageFiles.length} files.");

    for (var imageFile in imageFiles) {
      if (imageFile != null) {
        try {
          String fileName =
              'products/${DateTime.now().millisecondsSinceEpoch.toString()}';
          TaskSnapshot snapshot =
              await FirebaseStorage.instance.ref(fileName).putFile(imageFile);
          String imageUrl = await snapshot.ref.getDownloadURL();
          imageUrls.add(imageUrl); // Storing URLs in the list
          print("Uploaded image URL: $imageUrl");
        } catch (e) {
          print("Failed to upload image: $e");
        }
      }
    }

    if (imageUrls.length == imageFiles.where((file) => file != null).length) {
      // All images are uploaded and URLs retrieved
      print("All images uploaded successfully. URLs: $imageUrls");
      addProduct(); // Call your function to add product details to Firestore here
    } else {
      print("Not all images were uploaded. Please check.");
    }
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
                  Text(
                    "Are you sure you want to add ${nameController.text}?",
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
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(4),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
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
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(4),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black),
                            ),
                            onPressed: () async {
                              await uploadImagesAndGetUrls(); // Inside of the function is the call addProduct() if images are uploaded successfully
                              Navigator.pop(
                                  context); // Optionally close the dialog after adding
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

  Widget createSliderItem(
      BuildContext context, int index, VoidCallback pickImage) {
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
          image: DecorationImage(
              image: imageFiles[index] != null
                  ? FileImage(imageFiles[index]!)
                  : const AssetImage("assets/images/FrameRepairImage.jpg")
                      as ImageProvider,
              fit: BoxFit.cover),
        ),
      ),
      Positioned(
          left: 0,
          top: 0,
          child: IconButton(
            onPressed: pickImage,
            icon: const Icon(Icons.add_circle, color: Colors.black, size: 30),
            tooltip: "Add Image",
          ))
    ]);
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
                  createSliderItem(context, 0, () => pickImage(0)),
                  createSliderItem(context, 1, () => pickImage(1)),
                  createSliderItem(context, 2, () => pickImage(2))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Product Name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: 380, // Set a fixed width for the TextField
                      child: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        ),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Product Number",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: 380, // Set a fixed width for the TextField
                      child: TextField(
                        controller: productModelNumberController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        ),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
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
                    SizedBox(
                      width: 380, // Set a fixed width for the TextField
                      child: TextField(
                        controller: descriptionController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        ),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
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
                    SizedBox(
                      width: 380, // Set a fixed width for the TextField
                      child: TextField(
                        controller: priceController,
                        decoration: const InputDecoration(
                          prefixText: '₱ ',
                          border: OutlineInputBorder(),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        ),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          // Wrapping the first column in an Expanded widget
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Product Color",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              DropdownButton<ColorLabel>(
                                value: selectedColor,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedColor = newValue;
                                    productColorController.text =
                                        newValue.toString().split('.').last;
                                  });
                                },
                                items: ColorLabel.values.map((color) {
                                  return DropdownMenuItem(
                                    value: color,
                                    child:
                                        Text(color.toString().split('.').last),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width:
                              15, // Optional: Provides spacing between the two fields
                        ),
                        Expanded(
                          // Wrapping the second column in an Expanded widget
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Product Quantity",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                width:
                                    200, // Set a fixed width for the TextField
                                child: TextField(
                                  controller: productQuantityController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 8),
                                  ),
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Has a Grade Selection?",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 380, // Set a fixed width for the TextField
                      child: TextField(
                        controller: productGradeController,
                        decoration: const InputDecoration(
                          
                          border: OutlineInputBorder(),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        ),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Should probably validate the inputs, before allowing a navpush
                    CreateButton(
                        buttontext: "Add Product",
                        navigator: () {
                          showaddProductDialog(context);
                          print('Name: ${nameController.text}');
                          print('Price: ${priceController.text}');
                          print('Description: ${descriptionController.text}');
                          print(
                              'Product Color: ${productColorController.text}');
                          print(
                              'Product Model Number: ${productModelNumberController.text}');
                          print(
                              'Product Quantity: ${productQuantityController.text}');
                          print(
                              'Product Grade: ${productGradeController.text}');
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
