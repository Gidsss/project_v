import 'package:flutter/material.dart';
import 'package:project_v/constants/app_constants.dart';
import 'package:project_v/widgets/Layout/headerfooter.dart';
import 'package:project_v/screens/main/explorescreen.dart';
import 'package:project_v/screens/main/ordersscreen.dart';
import 'package:project_v/screens/main/profilescreen.dart';
import 'package:project_v/screens/main/homescreen.dart';
import 'package:project_v/screens/main/schedulescreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HeaderFooter(
        context: context,
        title: "HeaderFooter",
        buttonStatus: const [true, false, false, false, false],
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
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        itemCreate(
                            AppConstants.menEyeglassCategoryIconPath, "Men"),
                        itemCreate(AppConstants.womenEyeglassCategoryIconPath,
                            "Women"),
                        itemCreate(
                            AppConstants.kidEyeglassCategoryIconPath, "Kids"),
                        itemCreate(AppConstants.readingEyeglassCategoryIconPath,
                            "Reading"),
                        itemCreate(AppConstants.trendyEyeglassCategoryIconPath,
                            "Trendy"),
                        itemCreate(AppConstants.roundEyeglassCategoryIconPath,
                            "Round"),
                        itemCreate(AppConstants.nerdyEyeglassCategoryIconPath,
                            "Nerdy"),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                child: itemHeader("Contact Lenses"),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        itemCreate(AppConstants.dailyContactsCategoryIconPath,
                            "Daily"),
                        itemCreate(AppConstants.weeklyContactsCategoryIconPath,
                            "Weekly"),
                        itemCreate(AppConstants.monthlyContactsCategoryIconPath,
                            "Monthly"),
                        itemCreate(AppConstants.yearlyContactsCategoryIconPath,
                            "Yearly"),
                        itemCreate(AppConstants.coloredContactsCategoryIconPath,
                            "Colored"),
                        itemCreate(
                            AppConstants.softContactsCategoryIconPath, "Soft"),
                        itemCreate(AppConstants.rigidContactsCategoryIconPath,
                            "Rigid"),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(
                  child: Text("Best Sellers",
                      style: TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w900))),
              const SizedBox(
                  width: 80,
                  child: Divider(
                    height: 4,
                    thickness: 2,
                    color: Colors.black,
                  )),
              const SizedBox(height: 10),
              SizedBox(
                height: 225,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          createBestSellerItem('Aviatorae', '2,999', '124',
                              AppConstants.aviatorBestSellerIconPath),
                          createBestSellerItem('Reumanim', '10,999', '55',
                              AppConstants.koreanBestSellerIconPath),
                          createBestSellerItem('Wayfarer Galore', '6,000', '99',
                              AppConstants.wayfarerBestSellerIconPath),
                          createBestSellerItem('Chameleon', '4,500', '532',
                              AppConstants.readingBestSellerIconPath),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      )
                    ]),
              ),
              const SizedBox(
                height: 20,
              )
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
  return SizedBox(
    width: 70,
    child: GestureDetector(
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
    ),
  );
}

Widget createBestSellerItem(String productName, String productPrice,
    String productSold, String productImage) {
  return SizedBox(
    width: 170,
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(productImage),
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 100,
                  child: Text(productName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Inter",
                          fontSize: 16),
                      overflow: TextOverflow.ellipsis),
                ),
                GestureDetector(
                    onTap: () {
                      // Logic to Follow
                    },
                    child: const Icon(Icons.chevron_right))
              ],
            ),
            const SizedBox(
              height: 7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 50,
                  child: Text(
                    '₱$productPrice',
                    style: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text('$productSold sold',
                    style: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 9,
                        fontWeight: FontWeight.w100),
                    overflow: TextOverflow.ellipsis)
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
