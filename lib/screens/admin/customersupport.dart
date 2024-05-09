import 'package:flutter/material.dart';
import 'package:project_v/screens/admin/interactiondetails.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/header2.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/adminfooter.dart';

import '../customer/chat/chatdetailscreen.dart';


class CustomerSupportScreen extends StatefulWidget {
  const CustomerSupportScreen({super.key});

  @override
  State<CustomerSupportScreen> createState() => _CustomerSupportScreenState();
}

class _CustomerSupportScreenState extends State<CustomerSupportScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const Header2(text: "Customer Supports"),
      body: Column(
        children: [
          Expanded(
           child: ListView.builder(
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
                       MaterialPageRoute(builder: (context) => const InteractionDetailsScreen()),
                     );
                   },
                 ),
               );
             },
           ),
          ),
          AdminFooter(buttonStatus: const [false, false, false, false, true], context: context),
        ],
      ),
    );
  }
}
