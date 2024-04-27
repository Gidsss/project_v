import 'package:flutter/material.dart';
import 'package:project_v/constants/app_constants.dart';
import 'package:project_v/widgets/Layout/footer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:project_v/screens/main/bookingscreenStepThree.dart';
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
          bottom: const PreferredSize(
            preferredSize: Size.zero,
            child: Text(
              "Set An Appointment",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
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
                    createHeader(
                        "2. When would you like to set the appointment?"),
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
                                        width: MediaQuery.of(context)
                                                .size
                                                .width *
                                            0.8, // Set the desired width
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: SfDateRangePicker(
                                            enablePastDates: false,
                                            todayHighlightColor: Colors.black,
                                            backgroundColor: Colors.white,
                                            selectionColor: Colors.black,
                                            headerStyle: const DateRangePickerHeaderStyle(backgroundColor: Colors.white, textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600) ),
                                            initialSelectedDate:
                                                DateTime.now(),
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
                            labelStyle: const TextStyle(fontSize: 14, height: 1),
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
                            labelStyle: const TextStyle(fontSize: 14, height: 1),
                            contentPadding: const EdgeInsets.all(8)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    createHeader("3. Review your appointment details"),
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
                            createHeader("Type of Appointment"),
                            const SizedBox(
                              height: 10,
                            ),
                            createTextFormField(
                                "Type of Appointment", context, null),
                            const SizedBox(
                              height: 15,
                            ),
                            createHeader("Date & Time of Appointment"),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                createTextFormField(
                                    "06/24/2024", context, 145.0),
                                createTextFormField(
                                    "10:00 AM", context, 145.0)
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            createHeader("Store Location"),
                            const SizedBox(
                              height: 10,
                            ),
                            createTextFormField("Address", context, null),
                            const SizedBox(
                              height: 15,
                            ),
                            createHeader("Optometrician"),
                            const SizedBox(
                              height: 10,
                            ),
                            createTextFormField(
                                "Dr. Aidan Valdancio", context, null),
                            const SizedBox(
                              height: 10,
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
        floatingActionButton: floatBar(context)
        // Call the method using the instance
        );
  }
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
                fixedSize: MaterialStateProperty.all<Size>(const Size(185, 45))),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const BookingScreenStepThree()),
              );
            },
            child: const Text(
              "Set Appointment",
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
          ),
        ),
      ],
    ),
  );
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
      style: const TextStyle(fontSize: 14, height: 1),
      onSaved: (String? value) {},
      validator: (value) {
        return null;
      },
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: text,
          hintStyle: const TextStyle(fontSize: 14, height: 1),
          labelStyle: const TextStyle(fontSize: 14, height: 1),
          contentPadding: const EdgeInsets.all(8)),
    ),
  );
}
