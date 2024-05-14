import 'package:flutter/material.dart';
import 'package:project_v/screens/admin/products/addproduct.dart';
import '../../../widgets/CustomFooterHeaderWidgets/adminfooter.dart';
import '../../../widgets/CustomFooterHeaderWidgets/header2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Draw category types from category types firebase collection.

class AddNewCategoryScreen extends StatefulWidget {
  const AddNewCategoryScreen({super.key});

  @override
  State<AddNewCategoryScreen> createState() => _AddNewCategoryScreenState();
}

class _AddNewCategoryScreenState extends State<AddNewCategoryScreen> {
  final db = FirebaseFirestore.instance;
  List<String> categorytypeList = [];
  TextEditingController catName = TextEditingController();
  TextEditingController catTypeName = TextEditingController();
  String? selectedCategoryType;

  Future<void> fetchCategory() async {
    QuerySnapshot snapShot = await db.collection("categorytypes").get();

    for (DocumentSnapshot docs in snapShot.docs) {
      var catData = docs.data() as Map<String, dynamic>;
      categorytypeList.add(catData["categorytypename"]);
    }
    setState(() {});
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

  Widget createButton(String text, void Function() dialog) {
    return Center(
      child:
          //Save Button
          ElevatedButton(
        onPressed: dialog,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              Colors.black), // Button background color
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0), // Button border radius
            ),
          ),
          elevation: MaterialStateProperty.all(0), // Set button elevation to 0
          overlayColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.grey; // Change color on pressed
              }
              return Colors.black; // Set default overlay color
            },
          ),
          minimumSize: MaterialStatePropertyAll(Size(
              MediaQuery.of(context).size.width * 0.95,
              MediaQuery.of(context).size.height *
                  0.06)), // Adjust the width and height
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: "Inter",
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
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
        value: selectedCategoryType,
        onChanged: (String? newValue) {
          setState(() {
            selectedCategoryType = newValue!;
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

  void _showAddCategoryDialog() async {
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
                    "Add Category",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Are you sure you want to add the category?",
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
                          onPressed: () async {
                            // Call a function to save the changes
                            await _addCategory();
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

  void _showAddCategoryTypeDialog() async {
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
                    "Add Category Type",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Are you sure you want to add the category type?",
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
                          onPressed: () async {
                            // Call a function to save the changes
                            await _addCategoryType();
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

  Future<void> _addCategory() async {
    if (catName.text.isNotEmpty && selectedCategoryType!.isNotEmpty) {
      try {
        await db.collection('categories').add(
            {'category': catName.text, 'category_type': selectedCategoryType});
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'Added Category ${catName.text} of $selectedCategoryType.')));
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error adding category: $e')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text('Please fill out Category Name and Select Category Type.')));
    }
    // Implement the logic to save the changes here
    // You can use _selectedCategoryType and _categoryNameController.text to access the edited values
  }

  Future<void> _addCategoryType() async {
    if (catTypeName.text.isNotEmpty) {
      try {
        await db.collection('categorytypes').add({
          'categorytypename': catTypeName.text,
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Added Category Type ${catTypeName.text}.')));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error adding category type: $e')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill out Category Type Name')));
    }
    // Implement the logic to save the changes here
    // You can use _selectedCategoryType and _categoryNameController.text to access the edited values
  }

  @override
  void initState() {
    super.initState();
    fetchCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const Header2(text: "Add New Category"),
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
                    createHeader("Select Category Type"),
                    const SizedBox(height: 5),

                    createdropDown(),
                    const SizedBox(height: 25),

                    //Category Name
                    createHeader("Add Category Name"),
                    const SizedBox(height: 5),

                    createTextField("Category Name", catName),

                    const SizedBox(
                      height: 30,
                    ),

                    createButton("Add Category", _showAddCategoryDialog),

                    const SizedBox(
                      height: 25,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 25,
                    ),

                    //Category Name
                    createHeader("Add Category Type Name"),
                    const SizedBox(height: 5),

                    createTextField("Category Type Name", catTypeName),

                    const SizedBox(
                      height: 30,
                    ),

                    createButton(
                        "Add Category Type", _showAddCategoryTypeDialog),
                    const SizedBox(
                      height: 200,
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
