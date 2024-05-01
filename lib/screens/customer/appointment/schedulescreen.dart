import 'package:flutter/material.dart';
import 'package:project_v/constants/app_constants.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/customerheaderfooter.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:project_v/screens/customer/appointment/bookingscreenStepOne.dart';
import 'package:project_v/screens/customer/appointment/viewappointment.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen(
      {super.key, this.isNavigatedfromCancel, this.setIsNavigatedFromCancel});
  final bool? isNavigatedfromCancel;
  final Function(bool)? setIsNavigatedFromCancel;

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

TextEditingController datecontroller = TextEditingController();
TextEditingController numbercontroller = TextEditingController();
TextEditingController typecontroller = TextEditingController();

DateRangePickerController daterangeController = DateRangePickerController();

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.isNavigatedfromCancel == true) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100)),
                  height: 185, // Set the desired height
                  width: MediaQuery.of(context).size.width *
                      0.67, // Set the desired width
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Appointment Cancelled",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "Should you need to reschedule, place another appointment.",
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: ElevatedButton(
                                  style: const ButtonStyle(
                                      elevation: MaterialStatePropertyAll(4),
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.black)),
                                  onPressed: () {
                                    if (widget.setIsNavigatedFromCancel !=
                                        null) {
                                      widget.setIsNavigatedFromCancel!(false);
                                    }
                                    Navigator.pop(
                                      context,
                                    );
                                  },
                                  child: const Text(
                                    "Okay",
                                    style: TextStyle(color: Colors.white),
                                  ))),
                        )
                      ],
                    ),
                  )),
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return HeaderFooter(
      hasFloatbar: true,
      mainHeader: false,
      context: context,
      title: "Schedule",
      buttonStatus: const [false, false, true, false, false],
      floatbar: floatBar(context),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              children: [
                Expanded(
                    child: createTextFormField(
                        "Choose a date",
                        context,
                        Icons.calendar_month,
                        true,
                        datecontroller,
                        daterangeController)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              children: [
                Expanded(
                    child: createTextFormField("Type", context,
                        Icons.description, false, typecontroller, null)),
                const SizedBox(width: 10),
                Expanded(
                    child: createTextFormField("Number", context, 
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
                    separatorBuilder: (context, index) => const SizedBox(height: 15),
                    itemBuilder: (context, index) =>
                        createScheduleItem(context),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListView.separated(
                    itemCount: 10,
                    separatorBuilder: (context, index) => const SizedBox(height: 15),
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
              offset: const Offset(0, 3),
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
              image: const DecorationImage(
                image: AssetImage(AppConstants.eyeExamIconPath),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 190,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Mar 23, 2024",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: "Inter",
                            fontSize: 14),
                        overflow: TextOverflow.ellipsis),
                    Text("10:00 A.M.",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: "Inter",
                            fontSize: 14),
                        overflow: TextOverflow.ellipsis)
                  ],
                ),
                const SizedBox(height: 5),
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
          const SizedBox(
            width: 30,
          ),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ViewAppointmentOne()));
              },
              icon: const Icon(Icons.chevron_right),
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
    IconData icon,
    bool hasCalendar,
    TextEditingController textcontroller,
    DateRangePickerController? datecontroller) {
  return SizedBox(
    height: 35,
    child: TextFormField(
      controller: textcontroller,
      style: const TextStyle(fontSize: 14, height: 1),
      onSaved: (String? value) {},
      validator: (value) {
        return null;
      },
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
                                headerStyle: const DateRangePickerHeaderStyle(
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
          hintStyle: const TextStyle(fontSize: 14, height: 1),
          labelStyle: const TextStyle(fontSize: 14, height: 1),
          contentPadding: const EdgeInsets.all(8)),
    ),
  );
}
