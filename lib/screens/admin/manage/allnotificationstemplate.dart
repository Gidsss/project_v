import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../widgets/CustomFooterHeaderWidgets/adminfooter.dart';
import '../../../widgets/CustomFooterHeaderWidgets/header2.dart';
import 'editnotificationscreen.dart'; // Import the EditNotificationScreen

class AllNotificationsTemplateScreen extends StatefulWidget {
  const AllNotificationsTemplateScreen({super.key});

  @override
  State<AllNotificationsTemplateScreen> createState() => _AllNotificationsTemplateScreenState();
}

class _AllNotificationsTemplateScreenState extends State<AllNotificationsTemplateScreen> {
  // ignore: unused_field
  final List<int> _notifications = List.generate(30, (index) => index);

  Future<bool> _showDeleteNotificationTemplateDialog(int index) async {
    return await showDialog(
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
                    "Delete Template",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Are you sure you want to delete the template?",
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
                            Navigator.pop(context, false);
                          },
                          child: const Text("No", style: TextStyle(color: Colors.black)),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(4),
                            backgroundColor: MaterialStateProperty.all(Colors.black),
                          ),
                          onPressed: () {
                            Navigator.pop(context, true);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header2(text: "Notification Templates"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('notifications').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Error fetching notifications'));
                }
                final notifications = snapshot.data!.docs;
                return ListView.separated(
                  padding: const EdgeInsets.all(15.0),
                  itemCount: notifications.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 15),
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    return notificationsListTile(context, notification);
                  },
                );
              },
            ),
          ),
          AdminFooter(
            buttonStatus: const [false, false, true, false, false],
            context: context,
          ),
        ],
      ),
    );
  }

  Widget notificationsListTile(BuildContext context, QueryDocumentSnapshot notification) {
    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        final result = await _showDeleteNotificationTemplateDialog(notification.id as int);
        if (result) {
          await FirebaseFirestore.instance.collection('notifications').doc(notification.id).delete();
        }
        return result;
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        child: IconButton(
          icon: const Icon(Icons.delete, color: Colors.white),
          onPressed: () {},
        ),
      ),
      child: ListTile(
        leading: notification['imageUrl'] != null && notification['imageUrl'].isNotEmpty
            ? CircleAvatar(backgroundImage: NetworkImage(notification['imageUrl']))
            : const CircleAvatar(child: Icon(Icons.notifications)),
        title: Text(notification['title']),
        subtitle: Text(notification['message']),
        trailing: Text(notification['date']),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditNotificationScreen(
                notificationId: notification.id,
                notificationData: notification.data() as Map<String, dynamic>,
              ),
            ),
          );
        },
      ),
    );
  }
}
