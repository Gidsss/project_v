import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_v/screens/customer/homescreen.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/header2.dart';

class CheckOutItem {
  final String name;
  final String image;
  final String category;
  final double price;
  final int quantity;
  final String itemID;
  final String? promoCode;

  CheckOutItem(
      {required this.name,
      required this.image,
      required this.category,
      required this.price,
      required this.quantity,
      required this.itemID,
      this.promoCode});
}

class CheckOutScreen extends StatefulWidget {
  final String? promoCode;
  const CheckOutScreen({super.key, this.promoCode});

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final db = FirebaseFirestore.instance;
  double subtotal = 0;
  double discount = 0;
  double discountPercent = 0;
  double total = 0;

  final List<CheckOutItem> _checkoutItems = [];

  Future<void> loadCartItems() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String id = user.uid;

        QuerySnapshot snapshot =
            await db.collection("customers").doc(id).collection("carts").get();

        for (DocumentSnapshot cartRefQuant in snapshot.docs) {
          Map<String, dynamic> data =
              cartRefQuant.data() as Map<String, dynamic>;

          // Extract reference to the product document
          DocumentReference productRef = data['cartItemRef'];

          // Fetch the referenced product document
          DocumentSnapshot productSnapshot = await productRef.get();

          // Extract relevant data for each cart item

          String name = productSnapshot['name'];
          String category = productSnapshot['category'][0];
          String image = productSnapshot['imageUrls'][0];
          double price = double.parse(productSnapshot['price']);
          int quantity = data['Quantity'];

          // Create a CheckoutItem object and add it to the _checkOutItems list
          _checkoutItems.add(CheckOutItem(
            name: name,
            image: image,
            price: price,
            quantity: quantity,
            itemID: cartRefQuant.id,
            category: category,
          ));
        }
        // Update the UI after adding items to the list
        setState(() {});
      }
    } catch (error) {
      throw ("Failed to load the items: $error");
    }
  }

  Future<void> checkOut() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String id = user.uid;

        // Get customer's current user order number
        DocumentSnapshot customer =
            await db.collection("customers").doc(id).get();

        Map<String, dynamic> customerData =
            customer.data() as Map<String, dynamic>;

        int customerOrderNumber = customerData['customerOrderNumber'];

        // Add orders collection with doc of id-customerordernumber name.
        CollectionReference orderscollectRef = db.collection("orders");

        DocumentReference ordersdocRef =
            orderscollectRef.doc("$id-$customerOrderNumber");

        // Get reference to promo code
        DocumentReference? promoRef;

        if (widget.promoCode != null && widget.promoCode!.trim().isNotEmpty) {
          QuerySnapshot promoQuery = await db
              .collection("coupons")
              .where("couponCode", isEqualTo: widget.promoCode)
              .get();
          if (promoQuery.docs.isNotEmpty) {
            promoRef = promoQuery.docs.first.reference;
          
          } else {
            promoRef =
                null; // Handle the case where the promo code is not found
          }
        }

        // Add necessary details
        await ordersdocRef.set({
          "TrackingID": "$id-$customerOrderNumber",
          "DatePlaced": Timestamp.fromDate(
              DateTime.now()), // Sets the current time from the device
          "DateProcess": null,
          "DatePrepare": null,
          "DatePickup": null,
          "OrderPrice": subtotal,
          "PromoCode": promoRef,
          "Discount": discount,
          "IsActive": true,
          "User": id,
        });

        // Transfer all items from cart subcollection into orders, id-customerordernumber, subcollection.
        for (CheckOutItem item in _checkoutItems) {
          ordersdocRef
              .collection("items")
              .doc(item.itemID)
              .set(({
                "Quantity": item.quantity,
                "cartItemRef": db.collection('products').doc(item.itemID.substring(6))
              }));
        }

        // Increment customerordernumber of customer for the next transaction order.
        db
            .collection("customers")
            .doc(id)
            .update({"customerOrderNumber": customerOrderNumber + 1});

        // delete or reset the customer carts collection
        final querySnapshot =
            await db.collection("customers").doc(id).collection("carts").get();

        WriteBatch batch = db.batch();

        for (var doc in querySnapshot.docs) {
          batch.delete(doc
              .reference); // add a delete operation to the batch for each document
        }

        batch.commit();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Checked out Successfully.")));

        setState(() {});
      }
    } catch (error) {
      throw Exception("Error checking out: $error");
    }
  }

  void calculateTotals() {
    try {
      subtotal = 0;
      total = 0;

      for (CheckOutItem item in _checkoutItems) {
        subtotal += item.price * item.quantity;
      }
      discount = subtotal * discountPercent;
      total = subtotal - discount;
    } catch (error) {
      throw Exception("Error calculating totals:$error");
    }
  }

  Future<void> applyPromoCode(String? text) async {
    try {
      QuerySnapshot couponQuery = await db
          .collection("coupons")
          .where("couponCode", isEqualTo: widget.promoCode)
          .get();

      if (couponQuery.docs.isNotEmpty) {
        if (widget.promoCode != null) {
          // Assuming only one document is returned
          DocumentSnapshot coupon = couponQuery.docs.first;

          // Now you can access the data of the coupon
          Map<String, dynamic> couponData =
              coupon.data() as Map<String, dynamic>;

          // Example of accessing a specific field, like 'discount'
          int discountofCoupon = couponData['benefits'];

          discountPercent = discountofCoupon / 100;
        }
      }
    } catch (error) {
      throw Exception("Error applying promocode: $error");
    }
  }

  @override
  void initState() {
    super.initState();
    loadCartItems().then((_) {
      setState(() async{
        await applyPromoCode(widget.promoCode);
        calculateTotals();
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header2(text: "Checkout"),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: _checkoutItems.length + 3,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const ListTile(
                      title: Text(
                        'Store Address',
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 10.0),
                      ),
                      subtitle: Text(
                          'Sysco Building, 770 Rizal Avenue Street, Sta. Cruz, Manila, Philippines'),
                    );
                  } else if (index <= _checkoutItems.length) {
                    return ListTile(
                      leading: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: Image.network(_checkoutItems[index - 1].image, 
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },),
                      ),
                      title: Text(
                        _checkoutItems[index - 1].name,
                        style: const TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Category: ${_checkoutItems[index - 1].category}",
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 10.0,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            '₱${_checkoutItems[index - 1].price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (index == _checkoutItems.length + 1) {
                    return ListTile(
                        title: const Text(
                          'Promo Code',
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 10.0),
                        ),
                        subtitle: (widget.promoCode != null &&
                                widget.promoCode!.trim().isNotEmpty)
                            ? Text(
                                "${widget.promoCode} - ${discountPercent * 100}% off!")
                            : const Text("None"));
                  } else if (index == _checkoutItems.length + 2) {
                    return ListTile(
                      title: const Text(
                        'Order Details',
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 10.0),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Sub-Total:"),
                              Text("₱$subtotal")
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Discount:"),
                              Text("- ₱$discount")
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [const Text("Total:"), Text("₱$total")],
                          ),
                        ],
                      ),
                    );
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.95,
                height: 45,
                child: ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  onPressed: () {
                    checkOut();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.4,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Center(
                                    child: Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.black,
                                      size: 50,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    "Checked-Out Successfully!",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    "Thank you so much for your order.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Align(
                                    alignment: Alignment.center,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.black),
                                          fixedSize:
                                              MaterialStateProperty.all<Size>(
                                                  const Size(150, 35))),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HomeScreen()));
                                      },
                                      child: const Text(
                                        "Close",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: const Text('Checkout'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
