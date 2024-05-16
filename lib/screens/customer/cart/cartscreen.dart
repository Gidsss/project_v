import 'package:flutter/material.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/header2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'checkoutscreen.dart';

class CartItem {
  final String name;
  final String image;
  final double price;
  int quantity;
  final String cartID;

  CartItem(
      {required this.name,
      required this.image,
      required this.price,
      required this.quantity,
      required this.cartID});
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final db = FirebaseFirestore.instance;
  List<CartItem> _cartItems = [];
  double subtotal = 0;
  double discount = 0;
  double discountPercent = 0;
  double total = 0;
  TextEditingController couponController = TextEditingController();

  Future<void> _showDeleteConfirmation(int index, String cartid) async {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 250,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Remove from Cart?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipRRect(
                      child: Image.network(_cartItems[index].image,
                          width: 100, height: 100),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(_cartItems[index].name),
                        Text('₱${_cartItems[index].price.toStringAsFixed(2)}'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextButton(
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          fixedSize: MaterialStateProperty.all<Size>(Size(
                              MediaQuery.sizeOf(context).width * 0.4, 45))),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('No'),
                    ),
                    TextButton(
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          fixedSize: MaterialStateProperty.all<Size>(Size(
                              MediaQuery.sizeOf(context).width * 0.4, 45))),
                      onPressed: () async {
                        await deleteProduct(cartid);
                        setState(() {
                          _cartItems.removeAt(index);
                          calculateTotals();
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Successfully removed ${_cartItems[index].name} from cart.')));
                        Navigator.of(context).pop();
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> deleteProduct(String cartid) async {
    try {} catch (error) {
      throw Exception("Error deleting product: $error");
    }
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String id = user.uid;

      // Get cartitem and its quantity
      await db
          .collection("customers")
          .doc(id)
          .collection("carts")
          .doc(cartid)
          .delete();
    }
  }

  Widget createDetails() {
    return Column(children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [const Text("Sub-Total:"), Text("₱$subtotal")],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [const Text("Discount:"), Text("- ₱$discount")],
      ),
      const Divider(),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [const Text("Total:"), Text("₱$total")],
      ),
    ]);
  }

  Widget createButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.9,
        height: 45,
        child: ElevatedButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
          ),
          onPressed: () async {
            if (_cartItems.isNotEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CheckOutScreen()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("No items in cart. Cannot checkout.")));
            }
          },
          child: const Text(
            "Proceed to Checkout",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget createDetailsBar() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.39,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              offset: const Offset(
                0,
                -2,
              ),
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5,
              spreadRadius: 2)
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ), // Change this to your desired border radius
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: couponController,
              decoration: InputDecoration(
                labelText: 'Promo Code',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    applyPromoCode(couponController.text);
                    // Handle promo code application
                  },
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            createDetails(),
            createButton()
          ],
        ),
      ),
    );
  }

  void calculateTotals() {
    try {
      subtotal = 0;
      total = 0;

      for (CartItem item in _cartItems) {
        subtotal += item.price * item.quantity;
      }
      discount = subtotal * discountPercent;
      total = subtotal - discount;
    } catch (error) {
      throw Exception("Error calculating totals:$error");
    }
  }

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
          String image = productSnapshot['imageUrls'][0];
          double price = double.parse(productSnapshot['price']);
          int quantity = data['Quantity'];

          // Create a CartItem object and add it to the _cartItems list
          _cartItems.add(CartItem(
            name: name,
            image: image,
            price: price,
            quantity: quantity,
            cartID: cartRefQuant.id,
          ));
        }
        // Update the UI after adding items to the list
        setState(() {});
      }
    } catch (error) {
      throw ("Failed to load cart items: $error");
    }
  }

  Future<void> adjustQuantity(
      String operation, String cartid, int index) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String id = user.uid;
        // Get cartitem and its quantity
        DocumentSnapshot snapshot = await db
            .collection("customers")
            .doc(id)
            .collection("carts")
            .doc(cartid)
            .get();

        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        int productQuantity = data['Quantity'];

        if (operation == "-") {
          productQuantity -= 1;
        } else if (operation == "+") {
          productQuantity += 1;
        }
        await db
            .collection("customers")
            .doc(id)
            .collection("carts")
            .doc(cartid)
            .update({'Quantity': productQuantity});

        setState(() {
          _cartItems[index].quantity = productQuantity;
          calculateTotals();
        });
      }
    } catch (error) {
      throw Exception("Error modifying quantity: $error");
    }
  }

  Future<void> applyPromoCode(String text) async {
    try {
      QuerySnapshot couponQuery = await db
          .collection("coupons")
          .where("couponCode", isEqualTo: couponController.text)
          .get();

      if (couponQuery.docs.isNotEmpty) {

        if(_cartItems.isEmpty){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Cart is empty. Can't apply promo code.")));
        }
        else{
          // Assuming only one document is returned
        DocumentSnapshot coupon = couponQuery.docs.first;

        // Now you can access the data of the coupon
        Map<String, dynamic> couponData = coupon.data() as Map<String, dynamic>;

        // Example of accessing a specific field, like 'discount'
        int discountofCoupon = couponData['benefits'];

        discountPercent = discountofCoupon / 100;

        calculateTotals();
        setState(() {
        });

        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Promo code does not exist.")));
      }
    } catch (error) {
      throw Exception("Error applying promocode: $error");
    }
  }

  @override
  void initState() {
    super.initState();
    loadCartItems().then((_) {
      setState(() {
        calculateTotals();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const Header2(text: "My Cart"),
        body: _cartItems.isEmpty
            ? const Center(
                child: Text("You have no items in your cart. Add to cart now!"))
            : ListView.separated(
                itemCount: _cartItems.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(_cartItems[index].name),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.red,
                      child: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.white),
                        onPressed: () {
                          _showDeleteConfirmation(
                              index, _cartItems[index].cartID);
                        },
                      ),
                    ),
                    confirmDismiss: (direction) => Future.value(false),
                    child: ListTile(
                      leading: SizedBox(
                        width: 50.0, // Change this to your desired width
                        height: 50.0, // Change this to your desired height
                        child: Image.network(
                          _cartItems[index].image,
                        ),
                      ),
                      title: Text(
                        _cartItems[index].name,
                        style: const TextStyle(
                          fontSize:
                              15.0, // Change this to your desired font size
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '₱${_cartItems[index].price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize:
                                  15.0, // Change this to your desired font size
                            ),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              if (_cartItems[index].quantity > 1) {
                                adjustQuantity(
                                    "-", _cartItems[index].cartID, index);
                              } else if (_cartItems[index].quantity == 1) {
                                _showDeleteConfirmation(
                                    index, _cartItems[index].cartID);
                              }
                            },
                            child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.12,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.06,
                                decoration: BoxDecoration(
                                  color: Colors
                                      .grey, // Change this to your desired background color
                                  borderRadius: BorderRadius.circular(
                                      2), // Optional: to make the button round
                                ),
                                child: const Icon(
                                  Icons.remove,
                                  color: Colors.black,
                                )),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${_cartItems[index].quantity}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              if (_cartItems[index].quantity >= 1) {
                                adjustQuantity(
                                    "+", _cartItems[index].cartID, index);
                              }
                            },
                            child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.12,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.06,
                                decoration: BoxDecoration(
                                  color: Colors
                                      .black, // Change this to your desired background color
                                  borderRadius: BorderRadius.circular(
                                      2), // Optional: to make the button round
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
        bottomNavigationBar: createDetailsBar());
  }
}
