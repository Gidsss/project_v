import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_v/screens/customer/notifications/notificationdetailsscreen.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/header2.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final String currentUserUid = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Scaffold(
      appBar: const Header2(text: "Notifications"),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('notifications')
            .where('recipient', isEqualTo: currentUserUid)
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No notifications'));
          }

          return ListView(
            children:
                snapshot.data!.docs.map((DocumentSnapshot notificationDoc) {
              Map<String, dynamic> notificationData =
                  notificationDoc.data() as Map<String, dynamic>;
              String? imageUrl =
                  notificationData['imageUrl']; // Extracting the imageUrl
              return ListTile(
                leading: imageUrl != null && imageUrl.isNotEmpty
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(imageUrl),
                        radius: 24, // Adjust the size as needed
                      )
                    : const CircleAvatar(
                        child: Icon(Icons
                            .notifications), // Default icon if no image available
                        radius: 24,
                      ),
                title: Text(notificationData['title']),
                subtitle: Text(notificationData['message']),
                trailing: Text(notificationData['date']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationDetailScreen(
                          notificationData: notificationData),
                    ),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
