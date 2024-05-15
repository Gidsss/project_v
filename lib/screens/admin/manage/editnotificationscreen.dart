import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../widgets/CustomFooterHeaderWidgets/adminfooter.dart';
import '../../../widgets/CustomFooterHeaderWidgets/header2.dart';
import '../../../widgets/CustomWidgets/UniversalButton.dart';

class EditNotificationScreen extends StatefulWidget {
  final String notificationId;
  final Map<String, dynamic> notificationData;

  const EditNotificationScreen({
    Key? key,
    required this.notificationId,
    required this.notificationData,
  }) : super(key: key);

  @override
  State<EditNotificationScreen> createState() => _EditNotificationScreenState();
}

class _EditNotificationScreenState extends State<EditNotificationScreen> {
  List<File?> imageFiles = List.filled(1, null);
  final DateFormat dateFormat = DateFormat('MM/dd/yyyy');
  final ImagePicker picker = ImagePicker();
  bool showSearchBar = false;

  final TextEditingController DateController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  String? notificationType;
  String? priorityLevel;
  String? recipient;
  String? imageUrl;
  File? imageFile;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with the data
    titleController.text = widget.notificationData['title'];
    messageController.text = widget.notificationData['message'];
    DateController.text = widget.notificationData['date'];
    notificationType = widget.notificationData['type'];
    priorityLevel = widget.notificationData['priority'];
    recipient = widget.notificationData['recipient'];
    imageUrl = widget.notificationData['imageUrl'];
  }

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

  Future<void> pickImage(int index) async {
    try {
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          imageFile = File(pickedFile.path);
          imageFiles[index] = imageFile;
          imageUrl = null; // Clear imageUrl since a new image is picked
          print("Image picked at index $index: ${imageFiles[index]?.path}");
        });
      }
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> updateNotification() async {
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

    String imageUrlToSave = imageUrl ?? '';
    if (imageFile != null) {
      try {
        String fileName =
            'notifications/${DateTime.now().millisecondsSinceEpoch.toString()}';
        TaskSnapshot snapshot =
            await FirebaseStorage.instance.ref(fileName).putFile(imageFile!);
        imageUrlToSave = await snapshot.ref.getDownloadURL();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to upload image: $e')));
        return;
      }
    }

    try {
      await FirebaseFirestore.instance
          .collection('notifications')
          .doc(widget.notificationId)
          .update({
        'type': notificationType,
        'title': titleController.text,
        'message': messageController.text,
        'priority': priorityLevel,
        'recipient': recipient,
        'date': DateController.text,
        'imageUrl': imageUrlToSave // Only if image was uploaded
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Notification updated successfully!')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating notification: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header2(text: "Edit Notification"),
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
                                : (imageUrl != null && imageUrl!.isNotEmpty
                                    ? Image.network(
                                        imageUrl!,
                                        fit: BoxFit.cover,
                                      )
                                    : const Icon(
                                        Icons.add_a_photo,
                                        color: Colors.grey,
                                        size: 50,
                                      )),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Notification Type
                    buildDropdownRow(
                        'Notification Type', 'assets/images/EditIconBlack.png'),
                    buildDropdownContainer(
                      notificationType,
                      (String? newValue) {
                        setState(() {
                          notificationType = newValue!;
                        });
                      },
                      [
                        'Feedback and Reviews',
                        'Special Offers',
                        'Maintenance Alerts',
                        'Purchase Receipts'
                      ],
                    ),

                    const SizedBox(height: 15),

                    // Notification Recipient
                    buildDropdownRow('Notification Recipient',
                        'assets/images/EditIconBlack.png'),
                    buildDropdownContainer(
                      recipient,
                      (String? newValue) {
                        setState(() {
                          recipient = newValue!;
                          showSearchBar = newValue == 'Specific Customers';
                        });
                      },
                      ['All Customers', 'Specific Customers'],
                    ),

                    if (showSearchBar)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
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

                    // Priority Level
                    buildDropdownRow(
                        'Priority Level', 'assets/images/EditIconBlack.png'),
                    buildDropdownContainer(
                      priorityLevel,
                      (String? newValue) {
                        setState(() {
                          priorityLevel = newValue!;
                        });
                      },
                      ['Low Priority', 'High Priority'],
                    ),

                    const SizedBox(height: 15),

                    // Notification Title
                    buildTextFieldRow('Notification Title',
                        'assets/images/EditIconBlack.png'),
                    buildTextField('Notification Title', titleController),

                    const SizedBox(height: 15),

                    // Message Content
                    buildTextFieldRow(
                        'Message Content', 'assets/images/EditIconBlack.png'),
                    buildTextField('Message Content', messageController,
                        maxLines: 3),

                    const SizedBox(height: 15),
                    const Text("Date",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    buildDatePickerField("", DateController),
                    // Save Notification Button
                    CreateButton(
                      buttontext: 'Save Changes',
                      navigator: updateNotification,
                      context: context,
                    ),
                    const SizedBox(
                        width: 380, // Specify the exact width of the divider
                        child: Divider(
                          color: Colors.grey,
                          height: 20,
                          thickness: 1,
                        ),
                      ),
                    CreateButton(
                      buttontext: 'Send Notification',
                      navigator: updateNotification,
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

  Widget buildDropdownRow(String label, String iconPath) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: "Inter",
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 5),
        SizedBox(
          width: 18,
          height: 17,
          child: Image.asset(
            iconPath,
            width: 18,
            height: 17,
          ),
        ),
        const SizedBox(height: 25),
      ],
    );
  }

  Widget buildDropdownContainer(String? currentValue,
      ValueChanged<String?> onChanged, List<String> options) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[400]!),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButton<String>(
        value: currentValue,
        onChanged: onChanged,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 14,
          fontFamily: "Inter",
        ),
        icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
        isExpanded: true,
        iconSize: 30,
        dropdownColor: Colors.white,
        underline: Container(),
        items: options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: SizedBox(
              height: 50,
              child: Align(
                alignment: Alignment.center,
                child: Text(value),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget buildTextFieldRow(String label, String iconPath) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: "Inter",
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 6),
        SizedBox(
          width: 18,
          height: 17,
          child: Image.asset(
            iconPath,
            width: 18,
            height: 17,
          ),
        ),
      ],
    );
  }

  Widget buildTextField(String hintText, TextEditingController controller,
      {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[400]!),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[400]!),
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[400]!),
          borderRadius: BorderRadius.circular(15),
        ),
        enabled: true,
        focusedErrorBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        errorStyle: const TextStyle(height: 0),
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
