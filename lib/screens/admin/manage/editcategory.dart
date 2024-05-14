import 'package:flutter/material.dart';
import '../../../widgets/CustomFooterHeaderWidgets/adminfooter.dart';
import '../../../widgets/CustomFooterHeaderWidgets/header2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditCategoryScreen extends StatefulWidget {
  final String initialCategoryName;
  final String initialCategoryType;

  const EditCategoryScreen({
    super.key,
    required this.initialCategoryName,
    required this.initialCategoryType,
  });

  @override
  State<EditCategoryScreen> createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  final db = FirebaseFirestore.instance;
  List<String> categorytypeList = [];

  String? _selectedCategoryType; // Default selected category type
  late TextEditingController _categoryNameController;

  Future<void> _showSaveChangesDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 185,
            width: MediaQuery.of(context).size.width * 0.67,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Confirm Changes",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Are you sure you want to save the changes?",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.28,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("No",
                              style: TextStyle(color: Colors.black)),
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
                          onPressed: () {
                            // Call a function to save the changes
                            _saveChanges();
                            Navigator.pop(context);
                          },
                          child: const Text("Yes",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showDeleteDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 185,
            width: MediaQuery.of(context).size.width * 0.67,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Delete Category?",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Are you sure you want to delete?",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.28,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("No",
                              style: TextStyle(color: Colors.black)),
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
                            // Call a function to delete the category
                            _deleteCategory();
                            Navigator.pop(context);
                          },
                          child: const Text("Yes",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget createTextField(String text, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: text,
        contentPadding: const EdgeInsets.symmetric(
            vertical: 15, horizontal: 12), // Adjust the padding
        border: OutlineInputBorder(
          borderSide:
              BorderSide(color: Colors.grey[400]!), // Adjust the border color
          borderRadius: BorderRadius.circular(5), // Rounded corners
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.grey[400]!), // Adjust the border color when focused
          borderRadius: BorderRadius.circular(5), // Rounded corners
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.grey[400]!), // Adjust the border color when enabled
          borderRadius: BorderRadius.circular(5), // Rounded corners
        ),
        // Remove the underline
        enabled: true,
        focusedErrorBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        errorStyle: const TextStyle(height: 0),
        // Add any other TextField customization here
      ),
    );
  }

  Widget createHeader(String text) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: "Inter",
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 6), // Add some space between the icon and text
        SizedBox(
          width: 18,
          height: 17,
          child: Image.asset(
            'assets/images/EditIconBlack.png', // asset icon
            width: 18,
            height: 17,
          ),
        ),
      ],
    );
  }

  Widget createdropDown() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[400]!), // Add gray border
        borderRadius: BorderRadius.circular(5), // Rounded corners
      ),
      child: DropdownButton<String>(
        hint: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text("Select a Category Type"),
        ),
        value: _selectedCategoryType,
        onChanged: (String? newValue) {
          setState(() {
            _selectedCategoryType = newValue!;
          });
        },
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 14,
          fontFamily: "Inter",
        ), // Customize the dropdown button style
        icon: const Icon(Icons.arrow_drop_down,
            color: Colors.black), // Customize the dropdown icon color
        isExpanded: true, // Make the dropdown button expand horizontally
        iconSize: 30, // Adjust the size of the dropdown icon
        dropdownColor: Colors.white, // Customize the dropdown menu color
        underline: Container(), // Remove the underline
        items: categorytypeList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: SizedBox(
              height: 50, // Adjust the height of each dropdown item
              child: Align(
                alignment: Alignment.center, // Align items to the center
                child: Text(value),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Future<void> fetchCategory() async {
    try {
      QuerySnapshot snapShot = await db.collection("categorytypes").get();

      for (DocumentSnapshot docs in snapShot.docs) {
        var catData = docs.data() as Map<String, dynamic>;
        categorytypeList.add(catData["categorytypename"]);
      }
      setState(() {});
    } catch (error) {
      throw Exception("Failed to retrieve categories: $error");
    }
  }

  Future<void> _saveChanges() async {
    if ((_categoryNameController.text.isNotEmpty &&
            _categoryNameController.text != widget.initialCategoryName) ||
        (_categoryNameController.text.isNotEmpty &&
            _selectedCategoryType != widget.initialCategoryType)) {
      try {
        QuerySnapshot snapshot = await db
            .collection("categories")
            .where("category_type", isEqualTo: widget.initialCategoryType)
            .where("category", isEqualTo: widget.initialCategoryName)
            .get();
        String documentID = "";

        for (DocumentSnapshot doc in snapshot.docs) {
          documentID = doc.id;
        }

        await db.collection("categories").doc(documentID).update({
          "category": _categoryNameController.text,
          "category_type": _selectedCategoryType
        });

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Category Update Successful.')));
      } catch (error) {
        throw Exception("Error saving changes: $error");
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Please fill out New Category Name for saving or Change the Category Type.')));
      Navigator.pop(context);
    }
  }

  Future<void> _deleteCategory() async {
    try {
      QuerySnapshot snapshot = await db
          .collection("categories")
          .where("category_type", isEqualTo: widget.initialCategoryType)
          .where("category", isEqualTo: widget.initialCategoryName)
          .get();
      String documentID = "";

      for (DocumentSnapshot doc in snapshot.docs) {
        documentID = doc.id;
      }
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(documentID)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Category Deleted Successfully.')));
    } catch (error) {
      throw Exception("Error deleting Category: $error");
    }
    // Implement the logic to delete the category here
    // You can access the initial values from widget.initialCategoryName and widget.initialCategoryType
    // For example: call a function to delete the category from your data source
  }

  @override
  void initState() {
    super.initState();
    fetchCategory();
    _selectedCategoryType = widget.initialCategoryType;
    _categoryNameController =
        TextEditingController(text: widget.initialCategoryName);
  }

  @override
  void dispose() {
    _categoryNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const Header2(text: "Edit Category"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 25),
                    // Category Type Dropdown
                    createHeader("Select New Category Type"),
                    const SizedBox(height: 5),
                    createdropDown(),
                    const SizedBox(height: 25),

                    //Category Name
                    createHeader("Category Name"),
                    const SizedBox(height: 5),
                    createTextField(
                        "New Category Name", _categoryNameController),
                    SizedBox(
                      height: 30,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Save Button
                        ElevatedButton(
                          onPressed: _showSaveChangesDialog,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.black), // Button background color
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    40.0), // Button border radius
                              ),
                            ),
                            elevation: MaterialStateProperty.all(
                                0), // Set button elevation to 0
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors.grey; // Change color on pressed
                                }
                                return Colors
                                    .black; // Set default overlay color
                              },
                            ),
                            minimumSize: MaterialStateProperty.all(const Size(
                                160, 40)), // Adjust the width and height
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Save Edit',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        //Delete Button
                        ElevatedButton(
                          onPressed: _showDeleteDialog,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.red), // Button background color
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    40.0), // Button border radius
                              ),
                            ),
                            elevation: MaterialStateProperty.all(
                                0), // Set button elevation to 0
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors.grey; // Change color on pressed
                                }
                                return Colors
                                    .black; // Set default overlay color
                              },
                            ),
                            minimumSize: MaterialStateProperty.all(const Size(
                                160, 40)), // Adjust the width and height
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Delete',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          AdminFooter(
            buttonStatus: const [false, false, true, false, false],
            context: context,
          )
        ],
      ),
    );
  }
}
