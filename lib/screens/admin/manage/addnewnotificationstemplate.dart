import 'package:flutter/material.dart';
import '../../../widgets/CustomFooterHeaderWidgets/adminfooter.dart';
import '../../../widgets/CustomFooterHeaderWidgets/header2.dart';

class AddNewNotificationsTemplateScreen extends StatefulWidget {
  const AddNewNotificationsTemplateScreen({super.key});

  @override
  State<AddNewNotificationsTemplateScreen> createState() => _AddNewNotificationsTemplateScreenState();
}

class _AddNewNotificationsTemplateScreenState extends State<AddNewNotificationsTemplateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header2(text: "Add Notifications Template"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(

            ),
          ),
          AdminFooter(
              buttonStatus: const [false, false, true, false, false],
              context: context)
        ],
      ),
    );
  }
}
