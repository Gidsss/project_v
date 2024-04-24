import 'package:flutter/material.dart';
import 'package:project_v/constants/app_constants.dart';
import 'package:project_v/screens/main/bookingscreenStepTwo.dart';
import 'package:project_v/widgets/Layout/footer.dart';

class BookingScreenStepOne extends StatefulWidget {
  const BookingScreenStepOne({Key? key}) : super(key: key);

  @override
  State<BookingScreenStepOne> createState() => _BookingScreenStepOneState();
}

class _BookingScreenStepOneState extends State<BookingScreenStepOne> {
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
          SizedBox(height: 15),
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                child: Column(
                  children: [
                    Text(
                      "1. What type of appointment would you like to set?",
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20,20, 20, 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          createAppointmentItem("Eye Examination", AppConstants.eyeExamIconPath, context),
                          createAppointmentItem("Prescription Filling", AppConstants.PrescriptionFillingImagePath, context)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          createAppointmentItem("Frame Styling and Fitting", AppConstants.FrameFittingImagePath, context),
                          createAppointmentItem("Lens Fitting and adjustment", AppConstants.LensFittingImagePath, context),
                      
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          createAppointmentItem("Lens Replacement", AppConstants.LensReplacementImagePath, context),
                          createAppointmentItem("Frame Repair", AppConstants.FrameRepairImagePath, context),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          createAppointmentItem("Contact Lens Fitting", AppConstants.ContactLensFittingImagePath, context),
                          createAppointmentItem("Prescription Verification", AppConstants.PrescriptionVerificationImagePath, context),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          createAppointmentItem("Follow-up Care", AppConstants.FollowUpCareImagePath, context)
                        ],
                      ),
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
      // Call the method using the instance
    );
  }
}

Widget createAppointmentItem(String labelText, String image, context) {
  return InkWell(
    highlightColor: Colors.black.withOpacity(0.3),
    onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const BookingScreenStepTwo(),));},
    child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black.withOpacity(0.95),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ]),
        alignment: Alignment.center,
        child: Row(
          children: [
            Container(
              width: 155,
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(alignment: Alignment.topLeft , child: Text(labelText, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.white.withOpacity(0.9)))),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(image),
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ],
        )),
  );
}
