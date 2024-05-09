import 'package:flutter/material.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/customerheaderfooter.dart';
import '../../../constants/app_constants.dart';
import 'chatdetailscreen.dart';


class ChatScreen extends StatelessWidget {
  final String? tabName;
  const ChatScreen({Key? key, this.tabName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int initialTabIndex = tabName == "Messeges" ? 0 : 1;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 4,
        toolbarHeight: 40,
        centerTitle: true,
        title: Image.asset(
          AppConstants.logoImagePath,
          width: 40,
          height: 40,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: DefaultTabController(
              length: 2,
              initialIndex: initialTabIndex,
              child: Column(
                children: [
                  const TabBar(
                    labelColor: Colors.black,
                    indicatorColor: Colors.black,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: [
                      Tab(text: 'Messeges'),
                      Tab(text: 'Notifications'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: ListView.separated(
                            itemCount: 20,
                            separatorBuilder: (context, index) => const SizedBox(height: 15),
                            itemBuilder: (context, index) =>
                                Chats(context, index),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: ListView.separated(
                            itemCount: 10,
                            separatorBuilder: (context, index) => const SizedBox(height: 15),
                            itemBuilder: (context, index) =>
                                Notifications(context, index),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          buildFooter([false, false, false, false, true], context,
          ),
        ],
      ),
    );
  }
}


Widget Chats(BuildContext context, int index){
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
}

Widget Notifications(BuildContext context, int index){
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
}
