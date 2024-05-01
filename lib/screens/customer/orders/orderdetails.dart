import 'package:flutter/material.dart';
import 'package:project_v/constants/app_constants.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/customerfooter.dart';

class OrderDetailItem extends StatelessWidget {
  final String label;
  final String value;

  const OrderDetailItem({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18, // Adjust the font size of the label
            fontWeight: FontWeight.bold, // Optionally, set the font weight
          ),
        ),
        // Adjust the space between label and value
        Text(
          value,
          style: const TextStyle(
            fontSize: 18, // Adjust the font size of the value
          ),
        ),
      ],
    );
  }
}

class OrderStatusItem extends StatelessWidget {
  final String status;
  final String date;

  const OrderStatusItem({
    super.key,
    required this.status,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(status),
        const SizedBox(height: 5),
        Text(date),
        const SizedBox(height: 20),
      ],
    );
  }
}

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

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
        bottom: const PreferredSize(
          preferredSize: Size.zero,
          child: Text(
            "Track Order",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product image and description
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                              image:
                                  AssetImage('assets/images/product_1.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Brown Full Rim Round Glasses',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Category: Graded (-2.50) || Qty: 1',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              'Price: ₱1000.00',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const SizedBox(height: 5),
                    const Divider(color: Colors.black),
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        Text(
                          'Order Details',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const OrderDetailItem(
                      label: 'Expected Pick-up Date',
                      value: 'March 25, 2024',
                    ),
                    const SizedBox(height: 10),
                    const OrderDetailItem(
                      label: 'Tracking ID',
                      value: '#104523',
                    ),
                    const SizedBox(height: 15),
                    const SizedBox(height: 5),
                    const Divider(color: Colors.black),
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order Status',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'Active',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    // Order status and dates here
                    buildOrderStatusItem('Order Placed', 'March 20, 2024'),
                    buildOrderStatusItem(
                        'Order Processing', 'March 22, 2024'),
                    buildOrderStatusItem(
                        'Preparation in Progress', 'March 23, 2024'),
                    buildOrderStatusItem(
                        'Ready for Pick-up', 'March 24, 2024'),
                  ],
                ),
              ),
            ),
          ),
          buildFooter(
            [false, false, false, true, false],
            context,
          ),
        ],
      ),
    );
  }

  Widget buildOrderStatusItem(String status, String date) {
    IconData iconData;

    // Determine the icon based on the status
    switch (status) {
      case 'Order Placed':
        iconData = Icons.check_circle;
        break;
      case 'Order Processing':
        iconData = Icons.access_time;
        break;
      case 'Preparation in Progress':
        iconData = Icons.hourglass_empty;
        break;
      case 'Ready for Pick-up':
        iconData = Icons.local_shipping;
        break;
      default:
        iconData = Icons.info;
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(iconData), // Icon widget before the text
              const SizedBox(width: 8), // Space between icon and text
              Text(
                status,
                style: const TextStyle(
                  fontSize: 18, // Adjust the font size as needed
                  fontWeight:
                      FontWeight.bold, // Optionally, set the font weight
                ),
              ),
              const SizedBox(height: 40,)
            ],
          ),
          Text(
            date,
            style: const TextStyle(
              fontSize: 18,
              
            )
            
            
            ),
        ],
      ),
    );
  }
}
