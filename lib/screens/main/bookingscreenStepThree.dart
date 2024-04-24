import 'package:flutter/material.dart';
import 'package:project_v/constants/app_constants.dart';
import 'package:project_v/widgets/Layout/footer.dart';

class BookingScreenStepThree extends StatefulWidget {
  const BookingScreenStepThree({Key? key}) : super(key: key);

  @override
  State<BookingScreenStepThree> createState() => _BookingScreenStepThreeState();
}

class _BookingScreenStepThreeState extends State<BookingScreenStepThree> {
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
      body: Column(
        children: [
          Expanded(
              child: Center(
            child: Column(
              children: [
                SizedBox(height: 40,),
                Container(
                  child: Text(
                    "Successfully set an appointment.",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF005f32),
                        fontSize: 16),
                  ),
                ),
                SizedBox(height: 20,),
              Text("Please do not be late to your appointment."),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.fromLTRB(30,0,30,0),
                child: Divider(),
              ),
              SizedBox(height: 30,),
              Text("Your Appointment Number is:"),
              SizedBox(height: 10,),
              Text("123456", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),)
              ],
            ),
          )),
          buildFooter(
            [false, false, true, false, false],
            context,
          ),
        ],
      ),
      // Call the method using the instance
    );
  }
}
