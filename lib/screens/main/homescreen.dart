import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_v/constants/app_constants.dart';
import 'package:project_v/widgets/Layout/headerfooter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HeaderFooter(
        title: "HeaderFooter",
        buttonStatus: [true, false, false, false, false],
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              Container(
                  width: double.infinity,
                  color: Colors.black,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(8, 15, 8, 15),
                    child: Column(
                      children: [
                        Text(
                          "MARCH SALE MADNESS",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontFamily: "Lato",
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "12  :  14  :  23", // Temporary text solution, will be changed to dynamic once backend real-time countdown is implemented.
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontFamily: "Lato",
                              fontWeight: FontWeight.bold),
                        ),
                        Text("hour     min     sec",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: "Lato",
                            ))
                      ],
                    ),
                  )),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                child: itemHeader(
                  "Eyeglasses",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  itemCreate(AppConstants.meneyeglassIconPath, "Men"),
                  itemCreate(AppConstants.profileIconPath, "Women"),
                  itemCreate(AppConstants.profileIconPath, "Kids"),
                  itemCreate(AppConstants.profileIconPath, "Reading"),
                  itemCreate(AppConstants.profileIconPath, "Trendy")
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                child: itemHeader("Contact Lenses"),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  itemCreate(AppConstants.profileIconPath, "Daily"),
                  itemCreate(AppConstants.profileIconPath, "Weekly"),
                  itemCreate(AppConstants.profileIconPath, "Monthly"),
                  itemCreate(AppConstants.profileIconPath, "Bi-Annual"),
                  itemCreate(AppConstants.profileIconPath, "Yearly")
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              const Center(
                  child: Text("Best Sellers",
                      style: TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w900))),
              const SizedBox(
                  width: 80,
                  child: Divider(
                    height: 8,
                    thickness: 1,
                    color: Colors.black,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(scale: 2, AppConstants.meneyeglassIconPath),
                      Text("Gucci Eyes"),
                      Row(
                        children: [Text("2,999"), Text("1000 sold")],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

Widget itemHeader(String title) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: const TextStyle(
            fontSize: 20, fontFamily: "Inter", fontWeight: FontWeight.w600),
      ),
      GestureDetector(
        onTap: () {
          // Argument goes here. Navigate to Product Listings Page with Eyeglasses, or contact lenses category selected. (May need a new page that lists all subcategories of eyeglass, contact lenses?)
        },
        child: const Row(
          children: [
            Text("View all",
                style: TextStyle(
                    fontFamily: "Inter", fontWeight: FontWeight.w200)),
            Icon(
              Icons.chevron_right,
              size: 14,
            ),
          ],
        ),
      )
    ],
  );
}

Widget itemCreate(String image, String label) {
  return GestureDetector(
    onTap: () {
      // Argument goes here. Navigate to Product Listings Page with the relevant category selected.
    },
    child: Column(
      children: [
        SizedBox(
          width: 56,
          height: 56,
          child: CircleAvatar(radius: 80, backgroundImage: AssetImage(image)),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          label,
          style: const TextStyle(
              fontFamily: "Inter", fontSize: 12, fontWeight: FontWeight.w500),
        )
      ],
    ),
  );
}
