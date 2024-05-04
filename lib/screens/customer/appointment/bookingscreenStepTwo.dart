// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/customerfooter.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/header2.dart';
import 'package:project_v/widgets/CustomWidgets/floatbar.dart';
import 'package:project_v/widgets/CustomWidgets/labelHeader.dart';
import 'package:project_v/widgets/textfields/textfield2.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:project_v/screens/customer/appointment/bookingscreenStepThree.dart';
import 'package:intl/intl.dart';
import 'package:flutter/scheduler.dart';

class BookingScreenStepTwo extends StatefulWidget {
  const BookingScreenStepTwo({super.key});

  @override
  State<BookingScreenStepTwo> createState() => _BookingScreenStepTwoState();
}

class _BookingScreenStepTwoState extends State<BookingScreenStepTwo> {
  final TextEditingController dateController = TextEditingController();
  final DateRangePickerController daterangeController =
      DateRangePickerController();
  final TextEditingController timeController = TextEditingController();

  String _date = DateFormat('dd, MMMM yyyy').format(DateTime.now()).toString();

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    SchedulerBinding.instance.addPostFrameCallback((duration) {
      setState(() {
        _date = DateFormat('dd, MMMM yyyy').format(args.value).toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const Header2(text: "Set an Appointment"),
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            const SizedBox(height: 15),
            Expanded(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    const LabelHeader(text: "2. When would you like to set the appointment?"),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 35,
                      child: TextFormField(
                        controller: dateController,
                        onSaved: (String? value) {},
                        style: const TextStyle(fontSize: 14, height: 1),
                        validator: (value) {
                          return null;
                        },
                        decoration: InputDecoration(
                            suffixIcon: InkWell(
                              child: const Icon(Icons.calendar_month),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        height: 300, // Set the desired height
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8, // Set the desired width
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: SfDateRangePicker(
                                            enablePastDates: false,
                                            todayHighlightColor: Colors.black,
                                            backgroundColor: Colors.white,
                                            selectionColor: Colors.black,
                                            headerStyle:
                                                const DateRangePickerHeaderStyle(
                                                    backgroundColor:
                                                        Colors.white,
                                                    textStyle: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                            initialSelectedDate: DateTime.now(),
                                            controller: daterangeController,
                                            onSelectionChanged:
                                                selectionChanged,
                                            showActionButtons: true,
                                            onSubmit: (value) {
                                              // Update textFormField value with selected date
                                              dateController.text =
                                                  value.toString();
                                              Navigator.pop(context);
                                            },
                                            onCancel: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            border: const OutlineInputBorder(),
                            labelText: "Choose a date",
                            hintStyle: const TextStyle(fontSize: 14, height: 1),
                            labelStyle:
                                const TextStyle(fontSize: 14, height: 1),
                            contentPadding: const EdgeInsets.all(8)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 35,
                      child: TextFormField(
                        style: const TextStyle(fontSize: 14, height: 1),
                        controller: timeController,
                        onSaved: (String? value) {},
                        validator: (value) {
                          return null;
                        },
                        decoration: InputDecoration(
                            suffixIcon: InkWell(
                              child: const Icon(Icons.schedule),
                              onTap: () {},
                            ),
                            border: const OutlineInputBorder(),
                            labelText: "Choose a time",
                            hintStyle: const TextStyle(fontSize: 14, height: 1),
                            labelStyle:
                                const TextStyle(fontSize: 14, height: 1),
                            contentPadding: const EdgeInsets.all(8)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const LabelHeader(text: "3. Review your appointment details"),
                    const SizedBox(
                      height: 15,
                    ),
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
                            const LabelHeader(text: "Type of Appointment"),
                            const SizedBox(
                              height: 10,
                            ),
                            createtextField2(text: "Type of Appointment", context: context),
                            const SizedBox(
                              height: 15,
                            ),
                            const LabelHeader(text: "Date & Time of Appointment"),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                createtextField2(width: 145, text: "DD/MM/YYY", context: context),
                                createtextField2(width: 145, text: "HH:SS AM", context: context),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const LabelHeader(text: "Store Location"),
                            const SizedBox(
                              height: 10,
                            ),
                            createtextField2(text: "Address", context: context),
                            const SizedBox(
                              height: 15,
                            ),
                            const LabelHeader(text: "Optometrician"),
                            const SizedBox(
                              height: 10,
                            ),
                            createtextField2(text: "Dr. Aidan Valdancio", context: context),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 70,
                    )
                  ],
                ),
              ),
            )),
            buildFooter(
              [false, false, true, false, false],
              context,
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: createFloatbar(text: "Set Appointment", navigator: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const BookingScreenStepThree()),
              );
            },)
        );
  }
}
