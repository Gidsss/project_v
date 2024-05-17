import 'package:flutter/material.dart';
import 'package:project_v/constants/app_constants.dart';
import 'package:project_v/screens/customer/orders/orderdetails.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/customerheaderfooter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  final String itemID;
  final String? promoCode;

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
    required this.itemID,
    this.promoCode,
  });
}

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrdersScreen>
    with TickerProviderStateMixin {
  final db = FirebaseFirestore.instance;
  List<OrderItem> _orderItemsActive = [];
  List<OrderItem> _orderItemsComplete = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadOrders();
  }

  Future<void> loadOrders() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String id = user.uid;

        // Clear previous lists
        setState(() {
          _orderItemsActive.clear();
          _orderItemsComplete.clear();
          isLoading = true;
        });

        // Fetch active orders
        await fetchOrders(true, id);
        // Fetch completed orders
        await fetchOrders(false, id);

        setState(() {
          isLoading = false;
          print('State updated with loaded orders.'); // Debugging
          printFirstOrderItemActive(); // Print the first active order item
        });
      } else {
        print('No user is logged in.'); // Debugging
      }
    } catch (error) {
      print("Error loading orders: $error"); // Debugging
      throw Exception("Error loading orders: $error");
    }
  }

  Future<void> fetchOrders(bool isActive, String userId) async {
    try {

      // Get orders based on the isActive status and belonging to the user.
      QuerySnapshot orderQuery = await db
          .collection("orders")
          .where("IsActive", isEqualTo: isActive)
          .where("User", isEqualTo: userId)
          .get();

      print('Orders fetched for isActive=$isActive: ${orderQuery.docs.length}'); // Debugging

      if (orderQuery.docs.isNotEmpty) {
        // For each order found, get the relevant data.
        for (DocumentSnapshot order in orderQuery.docs) {
          try {
            print('Processing order: ${order.id}'); // Debugging
            Map<String, dynamic> data = order.data() as Map<String, dynamic>;

            String trackId = data['TrackingID'];
            String datePlaced = data['DatePlaced'] != null
                ? (data['DatePlaced'] as Timestamp).toDate().toString()
                : '';
            String dateProcess = data['DateProcess'] != null
                ? (data['DateProcess'] as Timestamp).toDate().toString()
                : '';
            String datePrepare = data['DatePrepare'] != null
                ? (data['DatePrepare'] as Timestamp).toDate().toString()
                : '';
            String datePickup = data['DatePickup'] != null
                ? (data['DatePickup'] as Timestamp).toDate().toString()
                : '';
            bool status = data['IsActive'];
            double orderPrice =
                data['OrderPrice'] != null ? data['OrderPrice'] + 0.0 : 0.0;
            double discount =
                data['Discount'] != null ? data['Discount'] + 0.0 : 0.0;

            // Get only the first item document from the items subcollection
            QuerySnapshot itemsSnapshot =
                await order.reference.collection('items').limit(1).get();

            print(
                'Items fetched for order ${order.id}: ${itemsSnapshot.docs.length}'); // Debugging

            if (itemsSnapshot.docs.isNotEmpty) {
              DocumentSnapshot item = itemsSnapshot.docs.first;
              Map<String, dynamic> itemData =
                  item.data() as Map<String, dynamic>;
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
                itemID: item.id,
                category: category, // Assuming category is a list
                trackId: trackId,
                datePlaced: datePlaced,
                dateProcess: dateProcess,
                datePrepare: datePrepare,
                datePickup: datePickup,
                status: status,
                promoCode: data['PromoCode'].toString(),
              );

              if (isActive) {
                _orderItemsActive.add(orderItem);
              } else {
                _orderItemsComplete.add(orderItem);
              }

              print('OrderItem added: ${productData['name']}'); // Debugging
            } else {
              print('No items found for order: ${order.id}'); // Debugging
            }
          } catch (e) {
            print('Error processing order ${order.id}: $e'); // Debugging
          }
        }
      } else {
        print('No orders found for user: $userId'); // Debugging
      }
    } catch (error) {
      print("Error fetching orders: $error"); // Debugging
      throw Exception("Error fetching orders: $error");
    }
  }

  void printFirstOrderItemActive() {
    if (_orderItemsActive.isNotEmpty) {
      OrderItem firstItem = _orderItemsActive.first;
      print('First Active OrderItem:');
      print('Track ID: ${firstItem.trackId}');
      print('Name: ${firstItem.name}');
      print('Date Placed: ${firstItem.datePlaced}');
      print('Price: ${firstItem.price}');
      print('Quantity: ${firstItem.quantity}');
      print('Image: ${firstItem.image}');
      print('Category: ${firstItem.category}');
      print('Promo Code: ${firstItem.promoCode}');
    } else {
      print('No active order items found.');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  String formatOrderNumber(String trackId) {
    String orderNumber = trackId.substring(29);
    orderNumber = orderNumber.padLeft(6 - trackId.substring(29).length, '0');
    return orderNumber;
  }

  @override
  Widget build(BuildContext context) {
    return HeaderFooter(
      hasFloatbar: true,
      mainHeader: false,
      context: context,
      title: "Orders",
      buttonStatus: const [false, false, false, true, false],
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 10), // Adjust vertical padding as needed
              child: TabBarView(
                children: [
                  // Active
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: ListView.separated(
                      itemCount: _orderItemsActive.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 15), // Adjust spacing between items
                      itemBuilder: (context, index) =>
                          createOrderItem(context, index, _orderItemsActive),
                    ),
                  ),
                  // Completed
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: ListView.separated(
                      itemCount: _orderItemsComplete.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 15), // Adjust spacing between items
                      itemBuilder: (context, index) =>
                          createOrderItem(context, index, _orderItemsComplete),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget createOrderItem(
      BuildContext context, int index, List<OrderItem> orderItems) {
    return orderItems.isNotEmpty ? GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OrderDetailsScreen(orderid: orderItems[index].trackId)),
        );
      },
      child: Container(
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(orderItems[index].image),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
              width: 190,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order #${orderItems[index].trackId.substring(0, 6)}-${formatOrderNumber(orderItems[index].trackId)}",
                        style: const TextStyle(
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
                        orderItems[index].name,
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
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrderDetailsScreen(orderid: orderItems[index].trackId)),
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
      ),
    )
    : Text("No orders yet.");
  }
}
