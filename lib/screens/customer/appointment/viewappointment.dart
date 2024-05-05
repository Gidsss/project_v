import 'package:flutter/material.dart';
import 'package:project_v/constants/app_constants.dart';
import 'package:project_v/screens/customer/appointment/cancelappointment.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/customerfooter.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/header2.dart';
import 'package:project_v/widgets/CustomWidgets/floatbar.dart';
import 'package:project_v/widgets/CustomWidgets/labelHeader.dart';
import 'package:project_v/widgets/textfields/textfield2.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ViewAppointmentOne extends StatefulWidget {
  const ViewAppointmentOne({super.key});

  @override
  State<ViewAppointmentOne> createState() => ViewAppointmentOneState();
}

class ViewAppointmentOneState extends State<ViewAppointmentOne> {
  final String qrData = "Your QR Code Data";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const Header2(text: "View Appointment"),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white.withOpacity(0.95),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: -1,
                                blurRadius: 4,
                                offset: const Offset(0, 3),
                              ),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              const LabelHeader(text: "Appointment Number"),
                              const SizedBox(
                                height: 10,
                              ),
                              createtextField2(
                                  text: "123456", context: context),
                              const SizedBox(
                                height: 15,
                              ),
                              const LabelHeader(text: "Type of Appointment"),
                              const SizedBox(
                                height: 10,
                              ),
                              createtextField2(
                                  text: "Type of Appointment",
                                  context: context),
                              const SizedBox(
                                height: 15,
                              ),
                              const LabelHeader(
                                  text: "Date & Time of Appointment"),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  createtextField2(
                                      width: 145,
                                      text: "DD/MM/YYY",
                                      context: context),
                                  createtextField2(
                                      width: 145,
                                      text: "HH:SS AM",
                                      context: context),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const LabelHeader(text: "Store Location"),
                              const SizedBox(
                                height: 10,
                              ),
                              createtextField2(
                                  text: "Address", context: context),
                              const SizedBox(
                                height: 15,
                              ),
                              const LabelHeader(text: "Optometrician"),
                              const SizedBox(
                                height: 10,
                              ),
                              createtextField2(
                                  text: "Dr. Aidan Valdancio",
                                  context: context),
                              const SizedBox(
                                height: 20,
                              ),
                              const LabelHeader(text: "QR Code:"),
                              QrImageView(
                                data: qrData,
                                version: QrVersions.auto,
                                size: 150.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                ),
              ),
            ),
            buildFooter(
              [false, false, true, false, false],
              context,
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: createFloatbar(
            text: "Cancel Appointment",
            navigator: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CancelAppointment()));
            }));
  }
}
