import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project_v/constants/app_constants.dart';
import 'package:project_v/screens/customer/explore/explorescreen.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/customerheaderfooter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project_v/screens/customer/explore/productdetails.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late DateTime _targetDateTime =
      DateTime(2024, 12, 31, 23, 59, 59); // Set a date for countdown
  Duration _remainingTime = const Duration();
  late Timer _timer;

  // Initialize lists
  final db = FirebaseFirestore.instance;
  List<String> prodDesc = [];
  List<String> prodName = [];
  List<String> prodPrice = [];
  List<String> prodSold = [];
  List<String> imageUrls = [];
  List<String> imageUrlsTemp = [];
  List<String> topProductIds = [];

  // Retrieve the top selling products
  Future<List<String>> getTopProducts() async {
    try {
      QuerySnapshot querySnapshot = await db
          .collection('products')
          .orderBy('sold', descending: true)
          .limit(5)
          .get();

      querySnapshot.docs.forEach((doc) {
        topProductIds.add(doc.id);
      });

      return topProductIds;
    } catch (error) {
      throw Exception('Failed to get top selling products: $error');
    }
  }

  // add the data of each top selling product to the list
  Future<void> initializeProducts() async {
    try {
      List<String> productIds = await getTopProducts();
      if (productIds.isNotEmpty) {
        for (String prodId in productIds) {
          await loadProductDetails(prodId);
        }
      }
    } catch (error) {
      print('Error initializing products: $error');
    }
  }

  Future<void> loadProductDetails(String productId) async {
    DocumentSnapshot productData =
        await db.collection('products').doc(productId).get();
    if (productData.exists) {
      Map<String, dynamic> data = productData.data() as Map<String, dynamic>;
      prodDesc.add(data['description']);
      prodName.add(data['name']);
      prodPrice.add(data['price']);
      prodSold.add(data['sold']);
      imageUrlsTemp.addAll(List.from(data['imageUrls']));
      imageUrls.add(imageUrlsTemp[0]);
      imageUrlsTemp = [];
      setState(() {});
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${duration.inHours}  :  $twoDigitMinutes  :  $twoDigitSeconds";
  }

  Future<void> _loadTargetDateTime() async {
    final prefs = await SharedPreferences.getInstance();
    final targetTimeString = prefs.getString('targetDateTime');
    if (targetTimeString != null) {
      _targetDateTime = DateTime.parse(targetTimeString);
      _updateRemainingTime();
    }
  }

  // Calculate remaining time based on the target date/time and current date/time
  void _updateRemainingTime() {
    final now = DateTime.now();
    _remainingTime = _targetDateTime.difference(now);
    if (_remainingTime.isNegative) {
      _remainingTime = const Duration();
    }
    setState(() {});
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateRemainingTime();
    });
  }

  @override
  void initState() {
    super.initState();
    initializeProducts();
    _loadTargetDateTime().then((_) {
      _startTimer();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

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
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 15, 8, 15),
                    child: Column(
                      children: [
                        const Text(
                          "MARCH SALE MADNESS",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontFamily: "Lato",
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          _formatDuration(_remainingTime),
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontFamily: "Lato",
                              fontWeight: FontWeight.bold),
                        ),
                        const Text("hour     min     sec",
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
                  "Eyeglasses", context, "eyeglass"
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
                        itemCreate(AppConstants.menEyeglassCategoryIconPath,
                            "Men", context, "men"),
                        itemCreate(AppConstants.womenEyeglassCategoryIconPath,
                            "Women", context, "women"),
                        itemCreate(AppConstants.kidEyeglassCategoryIconPath,
                            "Kids", context, "kids"),
                        itemCreate(AppConstants.readingEyeglassCategoryIconPath,
                            "Reading", context, "reading"),
                        itemCreate(AppConstants.trendyEyeglassCategoryIconPath,
                            "Trendy", context, "trendy"),
                        itemCreate(AppConstants.roundEyeglassCategoryIconPath,
                            "Round", context, "round"),
                        itemCreate(AppConstants.nerdyEyeglassCategoryIconPath,
                            "Nerdy", context, "nerdy"),
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
                child: itemHeader("Contact Lenses", context, "contacts"),
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
                            "Daily", context, "daily"),
                        itemCreate(AppConstants.weeklyContactsCategoryIconPath,
                            "Weekly", context, "weekly"),
                        itemCreate(AppConstants.monthlyContactsCategoryIconPath,
                            "Monthly", context, "monthly"),
                        itemCreate(AppConstants.yearlyContactsCategoryIconPath,
                            "Yearly", context, "yearly"),
                        itemCreate(AppConstants.coloredContactsCategoryIconPath,
                            "Colored", context, "colored"),
                        itemCreate(AppConstants.softContactsCategoryIconPath,
                            "Soft", context, "soft"),
                        itemCreate(AppConstants.rigidContactsCategoryIconPath,
                            "Rigid", context, "rigid"),
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
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: topProductIds.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            createBestSellerItem(
                                prodName[index],
                                prodPrice[index],
                                prodSold[index],
                                imageUrls[index],
                                context,
                                prodDesc[index]),
                          ],
                        ),
                      );
                    }),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ));
  }
}

Widget itemHeader(String title, BuildContext context, String navcategory) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: const TextStyle(
            fontSize: 20, fontFamily: "Inter", fontWeight: FontWeight.w600),
      ),
      InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ExploreScreen(navdcategory: navcategory)));
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

Widget itemCreate(
    String image, String label, BuildContext context, String navcategory) {
  return SizedBox(
    width: 70,
    child: InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ExploreScreen(navdcategory: navcategory)));
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

Widget createBestSellerItem(
    String productName,
    String productPrice,
    String productSold,
    String productImage,
    BuildContext context,
    String prodDescription) {
  return SizedBox(
    width: 170,
    child: Card(
      shadowColor: Colors.grey.withOpacity(0.5),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
          width: double.infinity,
          height: 135, // Adjust the height as needed
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(productImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
          const SizedBox(
            height: 7,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
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
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(
                                  imageURL: productImage,
                                  name: productName,
                                  price: productPrice,
                                  description: prodDescription)));
                    },
                    child: const Icon(Icons.chevron_right))
              ],
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Row(
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
          ),
        ],
      ),
    ),
  );
}
