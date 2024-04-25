import 'package:flutter/material.dart';
import 'package:project_v/constants/app_constants.dart';

import 'checkoutscreen.dart';

class CartItem {
  final String name;
  final String image;
  final String description;
  final double price;
  int quantity;

  CartItem({required this.name, required this.image, required this.description, required this.price, this.quantity = 1});
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> _cartItems = [
    CartItem(name: 'Aviator Glasses', image: 'assets/images/BestSellerAviator.jpg', description: 'Category: Graded (-2.50)', price: 1600.00),
    CartItem(name: 'Korean Glasses', image: 'assets/images/BestSellerKorean.jpg', description: 'Category: Graded (-2.50)', price: 1600.00),
    CartItem(name: 'Aviator Glasses', image: 'assets/images/BestSellerAviator.jpg', description: 'Category: Graded (-2.50)', price: 1600.00),
    CartItem(name: 'Korean Glasses', image: 'assets/images/BestSellerKorean.jpg', description: 'Category: Graded (-2.50)', price: 1600.00),
    CartItem(name: 'Aviator Glasses', image: 'assets/images/BestSellerAviator.jpg', description: 'Category: Graded (-2.50)', price: 1600.00),
    CartItem(name: 'Korean Glasses', image: 'assets/images/BestSellerKorean.jpg', description: 'Category: Graded (-2.50)', price: 1600.00),
    CartItem(name: 'Aviator Glasses', image: 'assets/images/BestSellerAviator.jpg', description: 'Category: Graded (-2.50)', price: 1600.00),
    CartItem(name: 'Korean Glasses', image: 'assets/images/BestSellerKorean.jpg', description: 'Category: Graded (-2.50)', price: 1600.00),
    // Add more items here
  ];

  Future<void> _showDeleteConfirmation(int index) async {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Remove from Cart?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0,),),
                Row(
                  children: <Widget>[
                    Image.asset(_cartItems[index].image, width: 100, height: 100),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('${_cartItems[index].name}'),
                        Text('${_cartItems[index].description}'),
                        Text('₱${_cartItems[index].price.toStringAsFixed(2)}'),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextButton(
                      child: Text('Cancel'),
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          fixedSize: MaterialStateProperty.all<Size>(Size(185, 45))),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Yes, Removed'),
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                          fixedSize: MaterialStateProperty.all<Size>(Size(185, 45))),
                      onPressed: () {
                        setState(() {
                          _cartItems.removeAt(index);
                        });
                        Navigator.of(context).pop();
                      },
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
        bottom: PreferredSize(
          child: Text(
            "My Cart",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          preferredSize: Size.zero,
        ),
      ),
      body: ListView.separated(
        itemCount: _cartItems.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(_cartItems[index].name),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20),
              color: Colors.red,
              child: IconButton(
                icon: Icon(Icons.delete, color: Colors.white),
                onPressed: () {
                  _showDeleteConfirmation(index);
                },
              ),
            ),
            confirmDismiss: (direction) => Future.value(false),
            child: ListTile(
              leading: Container(
                width: 50.0, // Change this to your desired width
                height: 50.0, // Change this to your desired height
                child: Image.asset(_cartItems[index].image),
              ),
              title: Text(
                _cartItems[index].name,
                style: TextStyle(
                  fontSize: 15.0, // Change this to your desired font size
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('${_cartItems[index].description}',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 10.0,
                      color: Colors.grey,
                    ),
                  ),
                  Text('₱${_cartItems[index].price.toStringAsFixed(2)}',style: TextStyle(
                    fontSize: 15.0, // Change this to your desired font size
                  ),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey, // Change this to your desired background color
                      borderRadius: BorderRadius.circular(2), // Optional: to make the button round
                    ),
                    child: IconButton(

                      icon: Icon(Icons.remove),
                      color: Colors.black,
                        onPressed: () {
                        setState(() {
                          if (_cartItems[index].quantity > 1) {
                            _cartItems[index].quantity--;
                          }
                        });
                      },
                    ),
                  ),
                  Text('${_cartItems[index].quantity}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,),),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black, // Change this to your desired background color
                      borderRadius: BorderRadius.circular(2), // Optional: to make the button round
                    ),
                    child: IconButton(

                      icon: Icon(Icons.add),
                      color: Colors.white,
                      onPressed: () {
                        setState(() {
                          _cartItems[index].quantity++;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey, // Change this to your desired border color
            width: 2.0, // Change this to your desired border width
          ),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
          ), // Change this to your desired border radius
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Promo Code',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      // Handle promo code application
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Sub-Total:                                                          ₱1600.00'),
                        Text('Handling Fee:                                                        ₱35.00'),
                        Text('Discount:                                                             - ₱80.00'),
                        Text('........................................................................................'),
                        Text('Total:                                                                  ₱1555.00'),
                        Text(''),
                      ]
                  ),

                ],

              ),
              ElevatedButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    fixedSize: MaterialStateProperty.all<Size>(Size(185, 45))),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CheckOutScreen()),
                  );
                },
                child: const Text(
                  "Proceed to Checkout",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
