import 'package:flutter/material.dart';
import 'package:project_v/screens/customer/appointment/schedulescreen.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/customerfooter.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/header2.dart';
import 'package:project_v/widgets/CustomWidgets/floatbarwithdialog.dart';

class CancelAppointment extends StatefulWidget {
  const CancelAppointment({super.key});

  @override
  State<CancelAppointment> createState() => CancelAppointmentState();
}

class CancelAppointmentState extends State<CancelAppointment> {
  int? selectedReason;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const Header2(text: "Cancel Appointment"),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                  "Kindly choose a reason for cancellation:"),
                              const SizedBox(height: 15),
                              createToggleItem("Change of Schedule", 1),
                              const SizedBox(height: 5),
                              createToggleItem("Weather Conditions", 2),
                              const SizedBox(height: 5),
                              createToggleItem("Unexpected Work", 3),
                              const SizedBox(height: 5),
                              createToggleItem("Travel Delays", 4),
                              const SizedBox(height: 5),
                              createToggleItem("Others", 5),
                              const SizedBox(height: 5),
                              const SizedBox(
                                height: 15,
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 5,
                              ),
                              const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Others")),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: TextField(
                                        maxLines: null,
                                        decoration: InputDecoration(
                                            isCollapsed: true,
                                            border: InputBorder.none,
                                            hintText: "Enter your reason...")),
                                  )),
                              const SizedBox(
                                height: 80,
                              )
                            ],
                          ),
                        ),
                      ),
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
        floatingActionButton:
            createdialogFloatbar(context, "Confirm Cancellation", () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const ScheduleScreen(isNavigatedfromCancel: true)));
        }));
  }

  Widget createToggleItem(String label, int value) {
    return Row(
      children: [
        Transform.scale(
          scale: 1.2,
          child: Radio(
            visualDensity: VisualDensity.compact,
            splashRadius: 15,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            fillColor: MaterialStateProperty.all(Colors.black),
            value: value,
            groupValue: selectedReason,
            onChanged: (int? newValue) {
              setState(() {
                selectedReason = newValue;
              });
            },
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(label)
      ],
    );
  }
}
