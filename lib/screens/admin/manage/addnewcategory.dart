import 'package:flutter/material.dart';
import '../../../widgets/CustomFooterHeaderWidgets/adminfooter.dart';
import '../../../widgets/CustomFooterHeaderWidgets/header2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddNewCategoryScreen extends StatefulWidget {
  const AddNewCategoryScreen({super.key});

  @override
  State<AddNewCategoryScreen> createState() => _AddNewCategoryScreenState();
}

class _AddNewCategoryScreenState extends State<AddNewCategoryScreen > {
  final db = FirebaseFirestore.instance;

  String _selectedCategoryType = 'Brand'; // Default selected category type

  Future<void> _showAddCategoryDialog() async {
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
                  Text(
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
                          child: const Text("No", style: TextStyle(color: Colors.black)),
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
                            _addCategory();
                            Navigator.pop(context);
                          },
                          child: const Text("Yes", style: TextStyle(color: Colors.white)),
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

  void _addCategory() {
    // Implement the logic to save the changes here
    // You can use _selectedCategoryType and _categoryNameController.text to access the edited values
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Row(
                      children: [
                        const Text(
                          "Category Type",
                          style: TextStyle(
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
                    ),
                    const SizedBox(height: 5),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[400]!), // Add gray border
                        borderRadius: BorderRadius.circular(5), // Rounded corners
                      ),
                      child: DropdownButton<String>(
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
                        icon: const Icon(Icons.arrow_drop_down, color: Colors.black), // Customize the dropdown icon color
                        isExpanded: true, // Make the dropdown button expand horizontally
                        iconSize: 30, // Adjust the size of the dropdown icon
                        dropdownColor: Colors.white, // Customize the dropdown menu color
                        underline: Container(), // Remove the underline
                        items: <String>[
                          'Brand',
                          'Color',
                          'Style',
                          'Frame',
                          'Price',
                        ].map<DropdownMenuItem<String>>((String value) {
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
                    ),

                    const SizedBox(height: 25),

                    //Category Name
                    Row(
                      children: [
                        const Text(
                          "Category Name",
                          style: TextStyle(
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
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Category Name",
                        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 12), // Adjust the padding
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[400]!), // Adjust the border color
                          borderRadius: BorderRadius.circular(5), // Rounded corners
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[400]!), // Adjust the border color when focused
                          borderRadius: BorderRadius.circular(5), // Rounded corners
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[400]!), // Adjust the border color when enabled
                          borderRadius: BorderRadius.circular(5), // Rounded corners
                        ),
                        // Remove the underline
                        enabled: true,
                        focusedErrorBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        errorStyle: TextStyle(height: 0),
                        // Add any other TextField customization here
                      ),
                    ),
                    SizedBox(height: 300,),

                    Center(
                      child:
                        //Save Button
                        ElevatedButton(
                          onPressed: _showAddCategoryDialog,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.black), // Button background color
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
                            minimumSize: MaterialStateProperty.all(const Size(160, 40)), // Adjust the width and height
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Add Category',
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

