import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_v/widgets/CustomWidgets/UniversalButton.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../widgets/CustomFooterHeaderWidgets/adminfooter.dart';
import '../../../widgets/CustomFooterHeaderWidgets/header2.dart';

class EditProduct extends StatefulWidget {
  final String? productId;

  const EditProduct({Key? key, this.productId}) : super(key: key);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController productQuantityController =
      TextEditingController();
  final TextEditingController soldController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  List<File?> imageFiles = List.filled(3, null);
  List<String> imageUrls = List.filled(3, '');

  @override
  void initState() {
    super.initState();
    loadProductDetails();
  }

  Future<void> loadProductDetails() async {
    DocumentSnapshot productData = await FirebaseFirestore.instance
        .collection('products')
        .doc(widget.productId)
        .get();
    if (productData.exists) {
      Map<String, dynamic> data = productData.data() as Map<String, dynamic>;
      nameController.text = data['name'];
      priceController.text = data['price'];
      descriptionController.text = data['description'];
      productQuantityController.text = data['productQuantity'];
      imageUrls = List.from(data['imageUrls']);
      setState(() {});
    }
  }

  Future<void> pickImage(int index) async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      uploadImage(imageFile, index);
    }
  }

  Future<void> uploadImage(File image, int index) async {
    String fileName =
        'product_images/${DateTime.now().millisecondsSinceEpoch}_$index.jpg';
    TaskSnapshot snapshot =
        await FirebaseStorage.instance.ref(fileName).putFile(image);
    String downloadUrl = await snapshot.ref.getDownloadURL();
    setState(() {
      imageFiles[index] = image;
      imageUrls[index] = downloadUrl;
    });
  }

  Future<void> submitProduct() async {
    DocumentSnapshot productData = await FirebaseFirestore.instance
        .collection('products')
        .doc(widget.productId)
        .get();

    if (!productData.exists) {
      print("No product found!");
      return;
    }

    Map<String, dynamic> data = productData.data() as Map<String, dynamic>;

    int currentQuantity = int.tryParse(data['productQuantity'].toString()) ?? 0;
    int currentSold = int.tryParse(data['sold']?.toString() ?? '0') ?? 0;

    int newlySold = int.tryParse(soldController.text) ?? 0;
    int updatedSold = currentSold + newlySold;
    int updatedQuantity = currentQuantity - newlySold;

    if (updatedQuantity < 0) {
      print("Error: Selling more than in stock!");
      return;
    }

    await FirebaseFirestore.instance
        .collection('products')
        .doc(widget.productId)
        .update({
      'name': nameController.text,
      'price': priceController.text,
      'description': descriptionController.text,
      'productQuantity': updatedQuantity.toString(), // Update the quantity
      'sold': updatedSold.toString(), // Save the sold quantity
      'imageUrls': imageUrls,
    });
    Navigator.pop(context);
  }

  Future<void> deleteProduct() async {
    await FirebaseFirestore.instance
        .collection('products')
        .doc(widget.productId)
        .delete();
    Navigator.pop(context);
  }

  Widget createSliderItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => pickImage(index),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageFiles[index] != null
                    ? FileImage(imageFiles[index]!)
                    : (imageUrls[index].isNotEmpty
                            ? NetworkImage(imageUrls[index])
                            : const AssetImage("assets/placeholder.png"))
                        as ImageProvider,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.7),
                  offset: Offset(2, 2),
                  blurRadius: 3,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: Icon(Icons.edit, color: Colors.white, size: 30),
          ),
        ],
      ),
    );
  }

  Future<void> showEditProductDialog(BuildContext context) async {
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
                    "Confirm Changes",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Are you sure you want to save the changes to ${nameController.text}?",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
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
                              submitProduct(); // This should handle the actual update logic
                              Navigator.pop(
                                  context); // Close the dialog after updating
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

  Widget createDeleteButton(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
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
                        "Delete Product?",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Are you sure you want to delete?",
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
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.white),
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
                                  backgroundColor: MaterialStatePropertyAll(
                                    Color.fromARGB(255, 192, 40, 29),
                                  ),
                                ),
                                onPressed: () {
                                  deleteProduct();
                                  Navigator.pop(context);
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
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 192, 40, 29),
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Center(
          child: Text(
            "Delete Product",
            style: TextStyle(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header2(text: "Edit Product"),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CarouselSlider.builder(
                    itemCount: imageUrls.length,
                    itemBuilder: (context, index, realIndex) {
                      return createSliderItem(context, index);
                    },
                    options: CarouselOptions(
                      height: 400,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      initialPage: 0,
                    ),
                  ),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    controller: priceController,
                    decoration: InputDecoration(labelText: 'Price'),
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                  ),
                  TextField(
                    controller: soldController,
                    decoration: InputDecoration(labelText: 'Sold'),
                  ),
                  CreateButton(
                      buttontext: "Save Changes",
                      navigator: () {
                        showEditProductDialog(context);
                      },
                      context: context),
                  createDeleteButton(context),
                ],
              ),
            ),
          ),
          AdminFooter(
              buttonStatus: const [false, true, false, false, false],
              context: context)
        ],
      ),
    );
  }
}
