import 'package:flutter/material.dart';
// import 'package:project_v/constants/app_constants.dart';
// import 'package:project_v/models/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
  final String imageURL;
  final String name;
  final String price;

  const ProductDetailScreen({
    super.key,
    required this.imageURL,
    required this.name,
    required this.price,
  });

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
                image: DecorationImage(
                  image: AssetImage(imageURL),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
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
              child: Text(
                'Price: $price', // Displays the price.
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.red, // Makes the price stand out.
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description", // Adds a description label.
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height:8), // Adjust vertical spacing between the label and description
                  Text(
                    "Elevate your eyewear style with our Stylish Metal Rectangle Glasses. These glasses combine modern design with durability, making them a perfect accessory for any occasion. The sleek rectangular frames are crafted from high-quality metal, ensuring both lightweight comfort and lasting strength.", // Adds a description label.
                    style: TextStyle(
                      fontSize: 20,
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