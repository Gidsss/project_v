import 'package:flutter/material.dart';
import '../../../widgets/CustomFooterHeaderWidgets/adminfooter.dart';
import '../../../widgets/CustomFooterHeaderWidgets/header2.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart'; // For date formatting

class AddNewNotificationsTemplateScreen extends StatefulWidget {
  const AddNewNotificationsTemplateScreen({super.key});

  @override
  State<AddNewNotificationsTemplateScreen> createState() => _AddNewNotificationsTemplateScreenState();
}

class _AddNewNotificationsTemplateScreenState extends State<AddNewNotificationsTemplateScreen> {
  String _selectedCategoryType = 'Feedback and Reviews'; // Default selected category type
  String _selectedCategoryType2 = 'All Customers'; // Default selected category type
  String _selectedCategoryType3 = 'Low Priority'; // Default selected category type
  List<File?> imageFiles = List.filled(1, null);
  final ImagePicker picker = ImagePicker();
  bool showSearchBar = false;
  final TextEditingController DateController = TextEditingController();
  final DateFormat dateFormat = DateFormat('MM/dd/yyyy');

  Future<void> selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = dateFormat.format(picked);
      });
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header2(text: "Add Notifications Template"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: () => pickImage(0), // Open image picker on tap
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: imageFiles[0] != null
                              ? Image.file(
                            imageFiles[0]!,
                            fit: BoxFit.cover,
                          )
                              : const Icon(
                            Icons.add_a_photo,
                            color: Colors.grey,
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),

                        //Notification Type
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Notification Type',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 5), // Add some space between the icon and text
                            SizedBox(
                              width: 18,
                              height: 17,
                              child: Image.asset(
                                'assets/images/EditIconBlack.png', // asset icon
                                width: 18,
                                height: 17,
                              ),
                            ),

                        const SizedBox(height: 25),
                      ],
                    ),

                    // Notification Type Dropdown
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[400]!), // Add gray border
                        borderRadius: BorderRadius.circular(15), // Rounded corners
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
                          'Feedback and Reviews',
                          'Special Offers',
                          'Maintenance Alerts',
                          'Purchase Receipts',
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

                    SizedBox(height: 15,),

                    //Notification Receipt
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Notification Receipt',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 5), // Add some space between the icon and text
                        SizedBox(
                          width: 18,
                          height: 17,
                          child: Image.asset(
                            'assets/images/EditIconBlack.png', // asset icon
                            width: 18,
                            height: 17,
                          ),
                        ),

                        const SizedBox(height: 25),
                      ],
                    ),

                    // Notification Receipt Dropdown
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[400]!), // Add gray border
                        borderRadius: BorderRadius.circular(15), // Rounded corners
                      ),
                      child: DropdownButton<String>(
                        value: _selectedCategoryType2,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedCategoryType2 = newValue!;
                            if (newValue == 'Specific Customers') {
                              showSearchBar = true;
                            } else {
                              showSearchBar = false;
                            }
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
                          'All Customers',
                          'Specific Customers',
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
                    if (showSearchBar)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Search Customer',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                // Add your search functionality here
                              },
                              icon: const Icon(Icons.search),
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 10),

                    //Priority Level
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Priority Level',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 5), // Add some space between the icon and text
                        SizedBox(
                          width: 18,
                          height: 17,
                          child: Image.asset(
                            'assets/images/EditIconBlack.png', // asset icon
                            width: 18,
                            height: 17,
                          ),
                        ),

                        const SizedBox(height: 25),
                      ],
                    ),

                    // Priority Level Dropdown
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[400]!), // Add gray border
                        borderRadius: BorderRadius.circular(15), // Rounded corners
                      ),
                      child: DropdownButton<String>(
                        value: _selectedCategoryType3,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedCategoryType3 = newValue!;
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
                          'Low Priority',
                          'High Priority',
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

                    SizedBox(height: 15,),

                    //Notification Title
                    Row(
                      children: [
                        const Text(
                          "Notification Title",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
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
                        hintText: "Notification Title",
                        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 12), // Adjust the padding
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[400]!), // Adjust the border color
                          borderRadius: BorderRadius.circular(15), // Rounded corners
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[400]!), // Adjust the border color when focused
                          borderRadius: BorderRadius.circular(15), // Rounded corners
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[400]!), // Adjust the border color when enabled
                          borderRadius: BorderRadius.circular(15), // Rounded corners
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

                    SizedBox(height: 15,),

                    //Message Content
                    Row(
                      children: [
                        const Text(
                          "Message Content",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
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
                        hintText: "Message Content",
                        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 12), // Adjust the padding
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[400]!), // Adjust the border color
                          borderRadius: BorderRadius.circular(15), // Rounded corners
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[400]!), // Adjust the border color when focused
                          borderRadius: BorderRadius.circular(15), // Rounded corners
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[400]!), // Adjust the border color when enabled
                          borderRadius: BorderRadius.circular(15), // Rounded corners
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
                    SizedBox(height: 15,),

                    const Text(
                      "Date",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    buildDatePickerField("", DateController),

               ],
            ),

          ),
        ),

      ),
      AdminFooter(
          buttonStatus: const [false, false, true, false, false],
          context: context)
        ],
      ),
    );
  }

  Widget buildDatePickerField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: GestureDetector(
        onTap: () => selectDate(context, controller),
        child: AbsorbPointer(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: label,
              suffixIcon: const Icon(Icons.calendar_today),
            ),
          ),
        ),
      ),
    );
  }
}
