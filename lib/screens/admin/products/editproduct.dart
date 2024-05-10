import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:project_v/widgets/CustomWidgets/UniversalButton.dart';
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
      productQuantityController.text = data['productQuantity']; // Load quantity
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
        'products/${DateTime.now().millisecondsSinceEpoch.toString()}';
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
    int currentQuantity = int.tryParse(productQuantityController.text) ?? 0;
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
      'productQuantity': updatedQuantity.toString(),
      'sold': updatedSold.toString(),
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
                : (imageUrls[index].isNotEmpty
                        ? NetworkImage(imageUrls[index])
                        : const AssetImage("assets/images/Valdo_LOGO.png"))
                    as ImageProvider,
            fit: BoxFit.cover,
          ),
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
      child: SizedBox(
        width: 380, // Adjust width to fit better
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
      ),
    );
  }

  Widget createSaveChangesButton(BuildContext context) {
    return SizedBox(
      width: 380, // Adjust width as needed
      child: InkWell(
        onTap: () {
          showEditProductDialog(
              context); // Make sure this function is defined to handle the save operation
        },
        child: SizedBox(
          width: 380, // Adjust width to fit better
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Center(
              child: Text(
                "Save Changes",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Inter',
                  fontSize: 16,
                ),
              ),
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
                  const SizedBox(height: 15),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // Aligns children to the start of the column (left side)
                    children: [
                      const Text(
                        "Product Name",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: 380, // Set a fixed width for the TextField
                        child: TextField(
                          controller: nameController,
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
                  const SizedBox(height: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // Aligns children to the start of the column (left side)
                    children: [
                      const Text(
                        "Price",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: 380, // Set a fixed width for the TextField
                        child: TextField(
                          controller: priceController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            prefixText: "₱ ",
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                          ),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // Aligns children to the start of the column (left side)
                    children: [
                      const Text(
                        "Product Description",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: 380, // Set a fixed width for the TextField
                        child: TextField(
                          controller: descriptionController,
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
                  const SizedBox(height: 15), // Add some space between the fields
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Product Quantity",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: 380,
                        child: TextField(
                          controller: productQuantityController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                          ),
                          style: const TextStyle(fontSize: 14),
                          keyboardType:
                              TextInputType.number, // Ensure numeric input only
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // Aligns children to the start of the column (left side)
                    children: [
                      const Text(
                        "Number of Items Sold",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: 380, // Set a fixed width for the TextField
                        child: TextField(
                          controller: soldController,
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
                  const SizedBox(height: 15),
                  Column(
                    children: [
                      createSaveChangesButton(context),
                      const SizedBox(
                        width: 380, // Specify the exact width of the divider
                        child: Divider(
                          color: Colors.grey,
                          height: 20,
                          thickness: 1,
                        ),
                      ),
                      createDeleteButton(context),
                    ],
                  ),
                  const SizedBox(height: 10),
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
