import 'package:flutter/material.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/header2.dart';
import '../chat/chatdetailscreen.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header2(text: "Notifications"),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key('message$index'),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              // Handle the action when the message is swiped
            },
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: Colors.red,
              child: IconButton(
                icon: const Icon(Icons.delete, color: Colors.white),
                onPressed: () {
                },
              ),
            ),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/PrescriptionFillingImage.jpg'),
              ),
              title: Text('Notification ${index + 1}'),
              subtitle: const Text('Notification details...'),
              trailing: const Text('12/02/2021 - 10:00 AM'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatDetailScreen()),
                );
              },
            ),
          );
        },
      ),
    );
  }
}