import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_v/constants/app_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductDetailScreen extends StatelessWidget {
  final String imageURL;
  final String name;
  final String price;
  final String description;
  final String id;

  const ProductDetailScreen(
      {super.key,
      required this.imageURL,
      required this.name,
      required this.price,
      required this.description,
      required this.id});

  Future<void> addCart(BuildContext context) async {
    try {
      final db = FirebaseFirestore.instance;
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String uid = user.uid;
        String productId = id;

        CollectionReference cartsCollection =
            db.collection("customers").doc(uid).collection("carts");

        // Check if the product already exists in the cart.
        DocumentSnapshot cartSnapshot =
            await cartsCollection.doc("order-$productId").get();

        // If document with id order-produtID does not exist, create a cart subcollection (if not exist)
        // and a document with cartItem value of prodRef and quantity 1
        if (!cartSnapshot.exists) {
          // Add cart item to the subcollection with reference and quantity as the name order-productID
          DocumentReference cartItemRef = db
              .collection("customers")
              .doc(uid)
              .collection("carts")
              .doc("order-$productId");

          await cartItemRef.set({
            'cartItemRef': db.collection('products').doc(productId),
            'Quantity': 1
          });

          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Added $name to cart successfully.')));
        }
        // document with the id order-productId already exists.
        else if (cartSnapshot.exists) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Product already exists in the cart.')),
          );
        }
      } else {
        throw Exception("Failed to get current user");
      }
    } catch (error) {
      throw Exception("Failed to add to cart: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name), // Displays the product name in the AppBar.
        backgroundColor: Colors.white,
        foregroundColor:
            Colors.black, // Sets text color to black for visibility.
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
                image: DecorationImage(
                  image: NetworkImage(imageURL),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '₱$price',
                    style: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      addCart(context);
                      //Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: SizedBox(
                      width: 28,
                      height: 28,
                      child: ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                        child: Image.asset(
                          AppConstants.addtoCartIconPath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Description", // Adds a description label.
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Adjust vertical spacing between the label and description
                  Text(
                    description,
                    // Adds a description label.
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            // You can add more widgets here to display additional information about the product.
          ],
        ),
      ),
    );
  }
}
