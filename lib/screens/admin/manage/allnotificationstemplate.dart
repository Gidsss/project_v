import 'package:flutter/material.dart';
import '../../../widgets/CustomFooterHeaderWidgets/adminfooter.dart';
import '../../../widgets/CustomFooterHeaderWidgets/header2.dart';

class AllNotificationsTemplateScreen extends StatefulWidget {
  const AllNotificationsTemplateScreen({super.key});

  @override
  State<AllNotificationsTemplateScreen> createState() => _AllNotificationsTemplateScreenState();
}

class _AllNotificationsTemplateScreenState extends State<AllNotificationsTemplateScreen> {
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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _notifications.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 15),
                      itemBuilder: (context, index) => Notifications(context, index),
                    ),
                  ],
                ),
              ),
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

  Widget Notifications(BuildContext context, int index) {
    return Dismissible(
      key: Key('message$index'),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        final result = await _showDeleteNotificationTemplateDialog(index);
        return result == true;
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
        leading: const CircleAvatar(
          backgroundImage: AssetImage('assets/images/PrescriptionFillingImage.jpg'),
        ),
        title: Text('Template ${index + 1}'),
        subtitle: const Text('Notification details...'),
        trailing: const Text('12/02/2024 - 11:00 AM'),
      ),
    );
  }
}
