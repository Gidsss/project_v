import 'package:flutter/material.dart';
import 'package:project_v/constants/app_constants.dart';
import 'package:project_v/widgets/Layout/footer.dart';
import 'package:qr_flutter/qr_flutter.dart';


class ViewAppointmentOne extends StatefulWidget{
  const ViewAppointmentOne({super.key});

  @override
  State<ViewAppointmentOne> createState() => ViewAppointmentOneState();
}

class ViewAppointmentOneState extends State<ViewAppointmentOne>{
  final String qrData = "Your QR Code Data"; 

  @override
  Widget build(BuildContext context){
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Text(
              "Successfully set an appointment.",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF005f32),
                fontSize: 16,
              ),
            ),
          ),
          Text("Please do not be late to your appointment."),
          SizedBox(height: 5),
          Text("This is your appointment QR code:"),
          SizedBox(height: 20),
          QrImageView(
            data: qrData,
            version: QrVersions.auto,
            size: 250.0,
          ),
          SizedBox(height: 20),
          Divider(),
          SizedBox(height: 20),
          Text("Your Appointment Number is:", style: TextStyle(fontSize: 16)),
          Text("123456", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          Expanded(child: Container()), // To push footer to the bottom
          buildFooter(
            [false, false, true, false, false],
            context,
          ),
        ],
      ),
    );
  }
}


