import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/header2.dart';

class NotificationDetailScreen extends StatelessWidget {
  final Map<String, dynamic> notificationData;

  const NotificationDetailScreen({Key? key, required this.notificationData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header2(text: "Notification Details"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (notificationData['imageUrl'] != null)
              Center(
                child: Image.network(
                  notificationData['imageUrl'],
                  fit: BoxFit.cover,
                ),
              ),
            Text("Date: ${notificationData['date']}", style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("Message: ${notificationData['message']}"),
            const SizedBox(height: 20),
            Text("Type: ${notificationData['type']}", style: const TextStyle(fontStyle: FontStyle.italic)),
            // Add more fields as necessary
          ],
        ),
      ),
    );
  }
}