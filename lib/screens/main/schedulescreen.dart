import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_v/constants/app_constants.dart';
import 'package:project_v/widgets/Layout/headerfooter.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:project_v/screens/main/bookingscreenStepOne.dart';
import 'package:project_v/screens/main/viewappointment.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

TextEditingController datecontroller = TextEditingController();
TextEditingController numbercontroller = TextEditingController();
TextEditingController typecontroller = TextEditingController();

DateRangePickerController daterangeController = DateRangePickerController();

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return HeaderFooter(
      hasFloatbar: true,
      mainHeader: false,
      context: context,
      title: "Screen",
      buttonStatus: const [false, false, true, false, false],
      floatbar: floatBar(context),
      body: Column(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              children: [
                Expanded(
                    child: createTextFormField(
                        "Choose a date",
                        context,
                        null,
                        Icons.calendar_month,
                        true,
                        datecontroller,
                        daterangeController)),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              children: [
                Expanded(
                    child: createTextFormField("Type", context, null,
                        Icons.description, false, typecontroller, null)),
                SizedBox(width: 10),
                Expanded(
                    child: createTextFormField("Number", context, null,
                        Icons.description, false, numbercontroller, null)),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListView.separated(
                    itemCount: 10,
                    separatorBuilder: (context, index) => SizedBox(height: 15),
                    itemBuilder: (context, index) =>
                        createScheduleItem(context),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListView.separated(
                    itemCount: 10,
                    separatorBuilder: (context, index) => SizedBox(height: 15),
                    itemBuilder: (context, index) =>
                        createScheduleItem(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget createScheduleItem(BuildContext context) {
  return Container(
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
      alignment: Alignment.center,
      child: Row(
        children: [
          Container(
            width: 90,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(AppConstants.eyeExamIconPath),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          SizedBox(width: 10),
          SizedBox(
            width: 190,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Mar 23, 2024",
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: "Inter",
                            fontSize: 14),
                        overflow: TextOverflow.ellipsis),
                    Text("10:00 A.M.",
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: "Inter",
                            fontSize: 14),
                        overflow: TextOverflow.ellipsis)
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Eye Exam",
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 11,
                            color: Colors.black.withOpacity(0.5),
                            fontWeight: FontWeight.w100),
                        overflow: TextOverflow.ellipsis),
                    Text("No. 123456",
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 11,
                            color: Colors.black.withOpacity(0.5),
                            fontWeight: FontWeight.w100),
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 30,
          ),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ViewAppointmentOne()));
              },
              icon: Icon(Icons.chevron_right),
              padding: const EdgeInsets.all(0),
              constraints: const BoxConstraints(),
              style: const ButtonStyle(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ))
        ],
      ));
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
                    builder: (context) => const BookingScreenStepOne()),
              );
            },
            child: const Text(
              "Set An Appointment",
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget createTextFormField(
    String text,
    BuildContext context,
    width,
    IconData icon,
    bool hasCalendar,
    TextEditingController textcontroller,
    DateRangePickerController? datecontroller) {
  return SizedBox(
    height: 35,
    width: width,
    child: TextFormField(
      controller: textcontroller,
      style: TextStyle(fontSize: 14, height: 1),
      onSaved: (String? value) {},
      validator: (value) {},
      decoration: InputDecoration(
          suffixIcon: InkWell(
            child: Icon(icon),
            onTap: () {
              hasCalendar
                  ? showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100)),
                            height: 300, // Set the desired height
                            width: MediaQuery.of(context).size.width *
                                0.8, // Set the desired width
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SfDateRangePicker(
                                enablePastDates: false,
                                todayHighlightColor: Colors.black,
                                backgroundColor: Colors.white,
                                selectionColor: Colors.black,
                                headerStyle: DateRangePickerHeaderStyle(
                                    backgroundColor: Colors.white,
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                initialSelectedDate: DateTime.now(),
                                controller: datecontroller,
                                showActionButtons: true,
                                onSubmit: (value) {
                                  // Update textFormField value with selected date
                                  textcontroller.text = value.toString();
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
                    )
                  : null;
            },
          ),
          border: const OutlineInputBorder(),
          labelText: text,
          hintStyle: TextStyle(fontSize: 14, height: 1),
          labelStyle: TextStyle(fontSize: 14, height: 1),
          contentPadding: const EdgeInsets.all(8)),
    ),
  );
}
