import 'package:flutter/material.dart';

class ChatDetailScreen extends StatelessWidget {
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
            "Black Luminaire",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          preferredSize: Size.fromHeight(20.0),
        ),
      ),
      body: ListView(
        children: <Widget>[
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
                  icon: Icon(Icons.camera_alt_outlined),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.send),
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

  MessageBubble({required this.sender, required this.text, required this.time, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: isMe ? BorderRadius.only(topLeft: Radius.circular(30.0), bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0)) : BorderRadius.only(topRight: Radius.circular(30.0), bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0)),
            elevation: 5.0,
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
