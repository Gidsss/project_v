import 'package:flutter/material.dart';
import '../../../widgets/CustomFooterHeaderWidgets/adminfooter.dart';
import '../../../widgets/CustomFooterHeaderWidgets/header2.dart';

class AllNotificationsTemplateScreen extends StatefulWidget {
  const AllNotificationsTemplateScreen({super.key});

  @override
  State<AllNotificationsTemplateScreen> createState() => _AllNotificationsTemplateScreenState();
}

class _AllNotificationsTemplateScreenState extends State<AllNotificationsTemplateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header2(text: "Notification Templates"),
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
