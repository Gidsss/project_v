import 'package:flutter/material.dart';
import '../chat/chatdetailscreen.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        toolbarHeight: 80,
        centerTitle: true,
        title: Image.asset(
          'assets/logos/logotrans.png',
          width: 40,
          height: 40,
        ),
        bottom: PreferredSize(
          child: Text(
            "Notifications",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          preferredSize: Size.zero,
        ),
      ),
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
              padding: EdgeInsets.symmetric(horizontal: 20),
              color: Colors.red,
              child: IconButton(
                icon: Icon(Icons.delete, color: Colors.white),
                onPressed: () {
                },
              ),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/images/PrescriptionFillingImage.jpg'),
              ),
              title: Text('Notification ${index + 1}'),
              subtitle: Text('Notification details...'),
              trailing: Text('12/02/2021 - 10:00 AM'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatDetailScreen()),
                );
              },
            ),
          );
        },
      ),
    );
  }
}