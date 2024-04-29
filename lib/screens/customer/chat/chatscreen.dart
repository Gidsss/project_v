import 'package:flutter/material.dart';
import 'chatdetailscreen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

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
        bottom: const PreferredSize(
          preferredSize: Size.zero,
          child: Text(
            "Messages",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
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
                backgroundImage: AssetImage('assets/images/TrendyCategory.jpg'),
              ),
              title: Text('Contact ${index + 1}'),
              subtitle: const Text('Last message...'),
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