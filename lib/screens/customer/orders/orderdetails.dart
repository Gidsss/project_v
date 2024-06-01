import 'package:flutter/material.dart';
import 'package:project_v/constants/app_constants.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/customerfooter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // Import intl package

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

class OrderItem {
  final String trackId;
  final String name;
  final String image;
  final String category;
  final String datePlaced;
  final String dateProcess;
  final String datePrepare;
  final String datePickup;
  final bool status;
  final double price;
  final int quantity;
  final double totalprice;

  OrderItem({
    required this.name,
    required this.trackId,
    required this.image,
    required this.category,
    required this.datePlaced,
    required this.dateProcess,
    required this.datePrepare,
    required this.datePickup,
    required this.status,
    required this.price,
    required this.quantity,
    required this.totalprice,
  });
}

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key, required this.orderid});

  final String orderid;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final db = FirebaseFirestore.instance;
  List<OrderItem> _orderItems = [];
  bool isLoading = true;
  String trackingID = "";

  @override
  void initState() {
    super.initState();
    loadOrders();
  }

  String formatOrderNumber(String trackId) {
    String orderNumber = trackId.substring(29);
    orderNumber = orderNumber.padLeft(6 - trackId.substring(29).length, '0');
    return orderNumber;
  }

  Future<void> loadOrders() async {
    try {
      trackingID = formatOrderNumber(widget.orderid);
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String id = user.uid;

        // Clear previous lists
        setState(() {
          _orderItems.clear();
          isLoading = true;
        });

        // Fetch active orders
        await fetchOrders(id);

        setState(() {
          isLoading = false;
          print('State updated with loaded orders.'); // Debugging
        });
      } else {
        print('No user is logged in.'); // Debugging
      }
    } catch (error) {
      print("Error loading orders: $error"); // Debugging
      throw Exception("Error loading orders: $error");
    }
  }

  Future<void> fetchOrders(String userId) async {
    try {
      // Get orders based on the isActive status and belonging to the user.
      DocumentSnapshot orderdocument =
          await db.collection("orders").doc(widget.orderid).get();

      // Get document data
      try {
        print('Processing order: ${orderdocument.id}'); // Debugging
        Map<String, dynamic> data =
            orderdocument.data() as Map<String, dynamic>;

        String trackId = data['TrackingID'];
        DateFormat dateFormat =
            DateFormat('yyyy-MM-dd'); // Define the date format

        String datePlaced = data['DatePlaced'] != null
            ? dateFormat.format((data['DatePlaced'] as Timestamp).toDate())
            : '';
        String dateProcess = data['DateProcess'] != null
            ? dateFormat.format((data['DateProcess'] as Timestamp).toDate())
            : '';
        String datePrepare = data['DatePrepare'] != null
            ? dateFormat.format((data['DatePrepare'] as Timestamp).toDate())
            : '';
        String datePickup = data['DatePickup'] != null
            ? dateFormat.format((data['DatePickup'] as Timestamp).toDate())
            : '';
        bool status = data['IsActive'];
        double orderPrice = 0.0;
        if (data['OrderPrice'] != null && data['Discount'] != null) {
          orderPrice = data['OrderPrice'] - data['Discount'];
        } else if (data['OrderPrice'] != null) {
          orderPrice = data['OrderPrice'];
        }

        // Get all items document from the items subcollection
        QuerySnapshot itemsSnapshot = await db
            .collection("orders")
            .doc(widget.orderid)
            .collection("items")
            .get();

        print(
            'Items fetched for order ${orderdocument.id}: ${itemsSnapshot.docs.length}'); // Debugging

        if (itemsSnapshot.docs.isNotEmpty) {
          for (DocumentSnapshot item in itemsSnapshot.docs) {
            Map<String, dynamic> itemData = item.data() as Map<String, dynamic>;
            DocumentReference productRef = itemData['cartItemRef'];

            // Fetch the referenced product document
            DocumentSnapshot productSnapshot = await productRef.get();

            Map<String, dynamic> productData =
                productSnapshot.data() as Map<String, dynamic>;

            String imageUrl = '';
            if (productData['imageUrls'] != null &&
                (productData['imageUrls'] as List).isNotEmpty) {
              imageUrl = productData['imageUrls'][0];
            }

            String category = '';
            if (productData['category'] != null &&
                (productData['category'] as List).isNotEmpty) {
              category = productData['category'][0];
            }

            OrderItem orderItem = OrderItem(
                name: productData['name'],
                image: imageUrl, // Assuming imageUrls is a list
                price: double.parse(productData['price']),
                quantity: itemData['Quantity'],
                category: category, // Assuming category is a list
                trackId: trackId,
                datePlaced: datePlaced,
                dateProcess: dateProcess,
                datePrepare: datePrepare,
                datePickup: datePickup,
                status: status,
                totalprice: orderPrice);

            _orderItems.add(orderItem);
            print('OrderItem added: ${productData['name']}'); // Debugging
          }
        } else {
          print('No items found for order: ${orderdocument.id}'); // Debugging
        }
      } catch (e) {
        print('Error processing order ${orderdocument.id}: $e'); // Debugging
      }
    } catch (error) {
      print("Error fetching orders: $error"); // Debugging
      throw Exception("Error fetching orders: $error");
    }
  }

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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
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
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _orderItems.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                    height: 15), // Adjust spacing between items
                            itemBuilder: (context, index) =>
                                createOrderItem(context, index),
                          ),

                          const SizedBox(height: 20),
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
                          OrderDetailItem(
                            label: 'Total Price (Discount Applied):',
                            value: "₱${_orderItems[0].totalprice}",
                          ),
                          const SizedBox(height: 10),
                          OrderDetailItem(
                            label: 'Tracking ID',
                            value: _orderItems.isNotEmpty
                                ? "#${_orderItems[0].trackId.substring(0, 6)}-${trackingID}"
                                : '',
                          ),
                          const SizedBox(height: 15),
                          const SizedBox(height: 5),
                          const Divider(color: Colors.black),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Order Status',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              _orderItems[0].status
                                  ? const Text(
                                      'Active',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    )
                                  : const Text(
                                      'Completed',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          // Order status and dates here
                          buildOrderStatusItem(
                              'Order Placed',
                              _orderItems.isNotEmpty
                                  ? _orderItems[0].datePlaced
                                  : ''),
                          buildOrderStatusItem(
                              'Order Processing',
                              _orderItems.isNotEmpty
                                  ? _orderItems[0].dateProcess
                                  : ''),
                          buildOrderStatusItem(
                              'Preparation in Progress',
                              _orderItems.isNotEmpty
                                  ? _orderItems[0].datePrepare
                                  : ''),
                          buildOrderStatusItem(
                              'Ready for Pick-up',
                              _orderItems.isNotEmpty
                                  ? _orderItems[0].datePickup
                                  : ''),
                          const SizedBox(
                            height: 20,
                          )
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
                  fontSize: 13, // Adjust the font size as needed
                  fontWeight:
                      FontWeight.bold, // Optionally, set the font weight
                ),
              ),
            ],
          ),
          Text(date,
              style: const TextStyle(
                fontSize: 16,
              )),
        ],
      ),
    );
  }

  Widget createOrderItem(BuildContext context, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(_orderItems[index].image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.6,
              child: Text(
                _orderItems[index].name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.6,
              child: Text(
                'Category: ${_orderItems[index].category} || Qty: ${_orderItems[index].quantity}',
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                ),
              ),
            ),
            Text(
              'Price: ₱${_orderItems[index].price}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
