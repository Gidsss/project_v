import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../widgets/CustomFooterHeaderWidgets/adminfooter.dart';
import '../../../widgets/CustomFooterHeaderWidgets/header2.dart';
import '../../../widgets/CustomWidgets/UniversalButton.dart';

class AddNewNotificationsTemplateScreen extends StatefulWidget {
  const AddNewNotificationsTemplateScreen({super.key});

  @override
  State<AddNewNotificationsTemplateScreen> createState() =>
      _AddNewNotificationsTemplateScreenState();
}

class _AddNewNotificationsTemplateScreenState
    extends State<AddNewNotificationsTemplateScreen> {
  List<File?> imageFiles = List.filled(1, null);
  final DateFormat dateFormat = DateFormat('MM/dd/yyyy');
  final ImagePicker picker = ImagePicker();
  bool showSearchBar = false;

  // ignore: non_constant_identifier_names
  final TextEditingController DateController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  String? notificationType;
  String? priorityLevel;
  String? recipient;
  File? imageFile;

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
          imageFile = File(pickedFile.path);
          imageFiles[index] = imageFile;
          print("Image picked at index $index: ${imageFiles[index]?.path}");
        });
      }
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  // Function to save the notification with validation
  Future<void> saveNotification() async {
    if (notificationType == null ||
        priorityLevel == null ||
        recipient == null ||
        titleController.text.isEmpty ||
        messageController.text.isEmpty ||
        DateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    String imageUrl = '';
    if (imageFile != null) {
      try {
        String fileName =
            'notifications/${DateTime.now().millisecondsSinceEpoch.toString()}';
        TaskSnapshot snapshot =
            await FirebaseStorage.instance.ref(fileName).putFile(imageFile!);
        imageUrl = await snapshot.ref.getDownloadURL();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to upload image: $e')));
        return;
      }
    }

    // Save notification to Firestore
    try {
      await FirebaseFirestore.instance.collection('notifications').add({
        'type': notificationType,
        'title': titleController.text,
        'message': messageController.text,
        'priority': priorityLevel,
        'recipient': recipient,
        'date': DateController.text,
        'imageUrl': imageUrl // Only if image was uploaded
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Notification saved successfully!')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving notification: $e')));
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
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                10), // Same border radius as container
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
                        const SizedBox(
                            width:
                                5), // Add some space between the icon and text
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
                        border: Border.all(
                            color: Colors.grey[400]!), // Add gray border
                        borderRadius:
                            BorderRadius.circular(15), // Rounded corners
                      ),
                      child: DropdownButton<String>(
                        value: notificationType,
                        onChanged: (String? newValue) {
                          setState(() {
                            notificationType = newValue!;
                          });
                        },
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontFamily: "Inter",
                        ), // Customize the dropdown button style
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors
                                .black), // Customize the dropdown icon color
                        isExpanded:
                            true, // Make the dropdown button expand horizontally
                        iconSize: 30, // Adjust the size of the dropdown icon
                        dropdownColor:
                            Colors.white, // Customize the dropdown menu color
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
                              height:
                                  50, // Adjust the height of each dropdown item
                              child: Align(
                                alignment: Alignment
                                    .center, // Align items to the center
                                child: Text(value),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    SizedBox(
                      height: 15,
                    ),

                    //Notification Receipt
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Notification Recipient',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                            width:
                                5), // Add some space between the icon and text
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
                        border: Border.all(
                            color: Colors.grey[400]!), // Add gray border
                        borderRadius:
                            BorderRadius.circular(15), // Rounded corners
                      ),
                      child: DropdownButton<String>(
                        value: recipient,
                        onChanged: (String? newValue) {
                          setState(() {
                            recipient = newValue!;
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
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors
                                .black), // Customize the dropdown icon color
                        isExpanded:
                            true, // Make the dropdown button expand horizontally
                        iconSize: 30, // Adjust the size of the dropdown icon
                        dropdownColor:
                            Colors.white, // Customize the dropdown menu color
                        underline: Container(), // Remove the underline
                        items: <String>[
                          'All Customers',
                          'Specific Customers',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: SizedBox(
                              height:
                                  50, // Adjust the height of each dropdown item
                              child: Align(
                                alignment: Alignment
                                    .center, // Align items to the center
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
                        const SizedBox(
                            width:
                                5), // Add some space between the icon and text
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
                        border: Border.all(
                            color: Colors.grey[400]!), // Add gray border
                        borderRadius:
                            BorderRadius.circular(15), // Rounded corners
                      ),
                      child: DropdownButton<String>(
                        value: priorityLevel,
                        onChanged: (String? newValue) {
                          setState(() {
                            priorityLevel = newValue!;
                          });
                        },
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontFamily: "Inter",
                        ), // Customize the dropdown button style
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors
                                .black), // Customize the dropdown icon color
                        isExpanded:
                            true, // Make the dropdown button expand horizontally
                        iconSize: 30, // Adjust the size of the dropdown icon
                        dropdownColor:
                            Colors.white, // Customize the dropdown menu color
                        underline: Container(), // Remove the underline
                        items: <String>[
                          'Low Priority',
                          'High Priority',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: SizedBox(
                              height:
                                  50, // Adjust the height of each dropdown item
                              child: Align(
                                alignment: Alignment
                                    .center, // Align items to the center
                                child: Text(value),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    SizedBox(
                      height: 15,
                    ),

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
                        const SizedBox(
                            width:
                                6), // Add some space between the icon and text
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
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: "Notification Title",
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 15, horizontal: 12), // Adjust the padding
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  Colors.grey[400]!), // Adjust the border color
                          borderRadius:
                              BorderRadius.circular(15), // Rounded corners
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey[
                                  400]!), // Adjust the border color when focused
                          borderRadius:
                              BorderRadius.circular(15), // Rounded corners
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey[
                                  400]!), // Adjust the border color when enabled
                          borderRadius:
                              BorderRadius.circular(15), // Rounded corners
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

                    SizedBox(
                      height: 15,
                    ),

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
                        const SizedBox(
                            width:
                                6), // Add some space between the icon and text
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
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: "Message Content",
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 15, horizontal: 12), // Adjust the padding
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  Colors.grey[400]!), // Adjust the border color
                          borderRadius:
                              BorderRadius.circular(15), // Rounded corners
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey[
                                  400]!), // Adjust the border color when focused
                          borderRadius:
                              BorderRadius.circular(15), // Rounded corners
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey[
                                  400]!), // Adjust the border color when enabled
                          borderRadius:
                              BorderRadius.circular(15), // Rounded corners
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
                    SizedBox(
                      height: 15,
                    ),

                    const Text(
                      "Date",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    buildDatePickerField("", DateController),
                    // Save Notification Button
                    CreateButton(
                      buttontext: 'Save as Template',
                      navigator: saveNotification,
                      context: context,
                    ),
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
