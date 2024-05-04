import 'package:flutter/material.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/header2.dart';

class ChatDetailScreen extends StatelessWidget {
  const ChatDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header2(text: "Black Luminaire"),
      body: ListView(
        children: const <Widget>[
          MessageBubble(
            sender: 'You',
            text: 'Hi! Is this Available?',
            time: 'SAT AT 9:01 PM',
            isMe: true,
          ),
          MessageBubble(
            sender: 'Black Luminator',
            text: 'Plastic Round Glasses\n₱2,999.00',
            time: 'SAT AT 9:11 PM',
            isMe: false,
          ),
          MessageBubble(
            sender: 'You',
            text: 'Make an Offer?',
            time: 'SAT AT 9:01 PM',
            isMe: true,
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Type Message...',
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.camera_alt_outlined),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String sender;
  final String text;
  final String time;
  final bool isMe;

  const MessageBubble({super.key, required this.sender, required this.text, required this.time, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: isMe ? const BorderRadius.only(topLeft: Radius.circular(30.0), bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0)) : const BorderRadius.only(topRight: Radius.circular(30.0), bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0)),
            elevation: 5.0,
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black54,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
