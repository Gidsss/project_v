import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_v/constants/app_constants.dart';
import 'package:project_v/widgets/Layout/footer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:project_v/screens/main/bookingscreenStepThree.dart';

class BookingScreenStepTwo extends StatefulWidget {
  const BookingScreenStepTwo({Key? key}) : super(key: key);

  @override
  State<BookingScreenStepTwo> createState() => _BookingScreenStepTwoState();
}

class _BookingScreenStepTwoState extends State<BookingScreenStepTwo> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

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
              "Set An Appointment",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            preferredSize: Size.zero,
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            SizedBox(height: 15),
            Expanded(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
                child: Container(
                  child: Column(
                    children: [
                      createHeader(
                          "2. When would you like to set the appointment?"),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 35,
                        child: TextFormField(
                          controller: dateController,
                          onSaved: (String? value) {},
                          style: TextStyle(fontSize: 14, height: 1),
                          validator: (value) {},
                          decoration: InputDecoration(
                              suffixIcon: InkWell(
                                child: Icon(Icons.calendar_month),
                                onTap: () {
                                  showDialog<Widget>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SfDateRangePicker(
                                          showActionButtons: true,
                                          onSubmit: (value) {
                                            // Return value and update textformfield
                                            Navigator.pop(context);
                                          },
                                          onCancel: () {
                                            Navigator.pop(context);
                                          },
                                        );
                                      });
                                },
                              ),
                              border: const OutlineInputBorder(),
                              labelText: "Choose a date",
                              hintStyle: TextStyle(fontSize: 14, height: 1),
                              labelStyle: TextStyle(fontSize: 14, height: 1),
                              contentPadding: const EdgeInsets.all(8)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 35,
                        child: TextFormField(
                          style: TextStyle(fontSize: 14, height: 1),
                          controller: timeController,
                          onSaved: (String? value) {},
                          validator: (value) {},
                          decoration: InputDecoration(
                              suffixIcon: InkWell(
                                child: Icon(Icons.schedule),
                                onTap: () {},
                              ),
                              border: const OutlineInputBorder(),
                              labelText: "Choose a time",
                              hintStyle: TextStyle(fontSize: 14, height: 1),
                              labelStyle: TextStyle(fontSize: 14, height: 1),
                              contentPadding: const EdgeInsets.all(8)),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      createHeader("3. Review your appointment details"),
                      SizedBox(
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
                                offset: Offset(0, 3),
                              ),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 70,
                      )
                    ],
                  ),
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
    padding: const EdgeInsets.only(bottom: 90.0, left: 15, right: 15),
    child: Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                fixedSize: MaterialStateProperty.all<Size>(Size(185, 45))),
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
