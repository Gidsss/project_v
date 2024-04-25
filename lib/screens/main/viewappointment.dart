import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_v/constants/app_constants.dart';
import 'package:project_v/screens/main/cancelappointment.dart';
import 'package:project_v/widgets/Layout/footer.dart';
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
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        shadowColor: Colors.black.withOpacity(0.4),
        elevation: 4,
        toolbarHeight: 80,
        centerTitle: true,
        title: Image.asset(
          AppConstants.logoImagePath,
          width: 40,
          height: 40,
        ),
        bottom: PreferredSize(
          child: Text(
            "View Appointment",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          preferredSize: Size.zero,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
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
                              offset: Offset(0, 3),
                            ),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            createHeader("Appointment Number"),
                            SizedBox(
                              height: 10,
                            ),
                            createTextFormField("#123456", context, null),
                            SizedBox(
                              height: 15,
                            ),
                            createHeader("Type of Appointment"),
                            SizedBox(
                              height: 10,
                            ),
                            createTextFormField("Type of Appointment", context, null),
                            SizedBox(
                              height: 15,
                            ),
                            createHeader("Date & Time of Appointment"),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                createTextFormField("06/24/2024", context, 145.0),
                                createTextFormField("10:00 AM", context, 145.0)
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            createHeader("Store Location"),
                            SizedBox(
                              height: 10,
                            ),
                            createTextFormField("Address", context, null),
                            SizedBox(
                              height: 15,
                            ),
                            createHeader("Optometrician"),
                            SizedBox(
                              height: 10,
                            ),
                            createTextFormField("Dr. Aidan Valdancio", context, null),
                            SizedBox(
                              height: 10,
                            ),
                            createHeader("QR Code:"),
                            QrImageView(
                              data: qrData,
                              version: QrVersions.auto,
                              size: 150.0,
                            ),
                          ],
                    
                        ),
                      ),
                    ),
                    SizedBox(height: 100,)
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
        floatingActionButton: floatBar(context)
    );
  }
}

Widget createHeader(String labelText) {
  return Align(
    alignment: Alignment.topLeft,
    child: Text(
      labelText,
    ),
  );
}

Widget createTextFormField(String text, context, width) {
  return SizedBox(
    height: 35,
    width: width,
    child: TextFormField(
      style: TextStyle(fontSize: 14, height: 1),
      onSaved: (String? value) {},
      validator: (value) {},
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: text,
          hintStyle: TextStyle(fontSize: 14, height: 1),
          labelStyle: TextStyle(fontSize: 14, height: 1),
          contentPadding: const EdgeInsets.all(8)),
    ),
  );
}

Widget floatBar(context) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 90.0, left: 30, right: 30),
    child: Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                fixedSize: MaterialStateProperty.all<Size>(Size(185, 45))),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CancelAppointment()));
            },
            child: const Text(
              "Cancel Appointment",
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
          ),
        ),
      ],
    ),
  );
}