import 'package:flutter/material.dart';
import 'package:project_v/constants/app_constants.dart';
import 'package:project_v/screens/customer/orders/orderdetails.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/customerheaderfooter.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';
// import 'package:project_v/screens/main/bookingscreenStepOne.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrdersScreen>
    with TickerProviderStateMixin {
  late TabController _ordersTabController;
  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _ordersTabController =
        TabController(length: 2, vsync: this); // Define the number of tabs here
  }

  @override
  void dispose() {
    _ordersTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HeaderFooter(
      hasFloatbar: true,
      mainHeader: false,
      context: context,
      title: "Orders",
      buttonStatus: const [false, false, false, true, false],
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 10), // Adjust vertical padding as needed
        child: TabBarView(
          controller: _ordersTabController,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView.separated(
                itemCount: 10,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 15), // Adjust spacing between items
                itemBuilder: (context, index) => createOrderItem(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView.separated(
                itemCount: 10,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 15), // Adjust spacing between items
                itemBuilder: (context, index) => createOrderItem(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget createOrderItem(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
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
        ],
      ),
      alignment: Alignment.center,
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppConstants.orderIconPath),
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: 185,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Order #104523",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: "Inter",
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Brown Full Rim Round Glasses",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.5),
                        fontWeight: FontWeight.w100,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 55),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const OrderDetailsScreen()),
              );
            },
            icon: const Icon(Icons.chevron_right),
            padding: const EdgeInsets.all(0),
            constraints: const BoxConstraints(),
            style: const ButtonStyle(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          )
        ],
      ),
    );
  }
}
