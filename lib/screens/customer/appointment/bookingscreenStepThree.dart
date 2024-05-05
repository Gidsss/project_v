import 'package:flutter/material.dart';
import 'package:project_v/constants/app_constants.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/customerfooter.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/header2.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BookingScreenStepThree extends StatelessWidget {
  final String qrData = "Your QR Code Data";

  const BookingScreenStepThree({super.key}); // Assign the actual QR code data here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header2(text: "Set an Appointment"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Text(
              "Successfully set an appointment.",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF005f32),
                fontSize: 16,
              ),
            ),
          ),
          const Text("Please do not be late to your appointment."),
          const SizedBox(height: 5),
          const Text("This is your appointment QR code:"),
          const SizedBox(height: 20),
          QrImageView(
            data: qrData,
            version: QrVersions.auto,
            size: 250.0,
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 20),
          const Text("Your Appointment Number is:", style: TextStyle(fontSize: 16)),
          const Text("123456", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
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
