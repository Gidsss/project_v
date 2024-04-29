import 'package:flutter/material.dart';
import '../../../constants/app_constants.dart';

class CheckOutItem {
  final String name;
  final String image;
  final String description;
  final double price;
  //int quantity;

  CheckOutItem({required this.name, required this.image, required this.description, required this.price}); //this.quantity = 1});
}

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}


class _CheckOutScreenState extends State<CheckOutScreen> {

  final List<CheckOutItem> _checkoutItems = [
    CheckOutItem(name: 'Aviator Glasses', image: 'assets/images/BestSellerAviator.jpg', description: 'Category: Graded (-2.50) || Qty: 1 pc', price: 1600.00),
    CheckOutItem(name: 'Korean Glasses', image: 'assets/images/BestSellerKorean.jpg', description: 'Category: Graded (-2.50) || Qty: 10 pcs', price: 1600.00),
    CheckOutItem(name: 'Aviator Glasses', image: 'assets/images/BestSellerAviator.jpg', description: 'Category: Graded (-2.50) || Qty: 12 pcs', price: 1600.00),
    CheckOutItem(name: 'Korean Glasses', image: 'assets/images/BestSellerKorean.jpg', description: 'Category: Graded (-2.50) Qty: 12 pcs', price: 1600.00),
    CheckOutItem(name: 'Aviator Glasses', image: 'assets/images/BestSellerAviator.jpg', description: 'Category: Graded (-2.50) || Qty: 12 pcs', price: 1600.00),
    CheckOutItem(name: 'Korean Glasses', image: 'assets/images/BestSellerKorean.jpg', description: 'Category: Graded (-2.50) Qty: 12 pcs', price: 1600.00),
    // Add more items here
  ];

  @override
  Widget build(BuildContext context) {
    double subTotal = _checkoutItems.fold(0, (sum, item) => sum + item.price);
    double discount = 80;
    double handlingFee = 35;
    double totalCost = subTotal + handlingFee - discount;

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
            "Checkout",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: ListView.separated(
        itemCount: _checkoutItems.length + 5,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          if (index == 0) {
            return const ListTile(
              title: Text(
                'Store Address',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10.0),
              ),
              subtitle: Text('143 Tokyo St., Tokyo Prefecture, 100'),
            );
          } else if (index <= _checkoutItems.length) {
            return ListTile(
              leading: SizedBox(
                width: 50.0,
                height: 50.0,
                child: Image.asset(_checkoutItems[index - 1].image),
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
                  Text(_checkoutItems[index - 1].description,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 10.0,
                      color: Colors.grey,
                    ),
                  ),
                  Text('₱${_checkoutItems[index - 1].price.toStringAsFixed(2)}',style: const TextStyle(
                    fontSize: 15.0,
                  ),
                  ),
                ],
              ),
            );
          } else if (index == _checkoutItems.length + 1) {
            return const ListTile(
              title: Text(
                'Expected Pickup Date',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10.0),
              ),
              subtitle: Text('24 March 2024 - 27 March 2024'),
            );
          } else if (index == _checkoutItems.length + 2) {
            return const ListTile(
              title: Text(
                'Promo Code',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10.0),
              ),
              subtitle: Text('VC5%Off'),
            );
          } else if (index == _checkoutItems.length + 3) {
            return ListTile(
              title: const Text(
                'Order Details',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10.0),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Sub-Total:                                                            ₱${subTotal.toStringAsFixed(2)}'),
                  Text('Handling Fee:                                                          ₱${handlingFee.toStringAsFixed(2)}'),
                  Text('Discount:                                                                -₱${discount.toStringAsFixed(2)}'),
                  const Divider(),
                  Text('Total Cost:                                                          ₱${totalCost.toStringAsFixed(2)}'),
                ],
              ),
            );
          } else if (index == _checkoutItems.length + 4) {
            return ElevatedButton(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  fixedSize: MaterialStateProperty.all<Size>(const Size(100, 20))),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: SizedBox(
                        height: 250,
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
                                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                      fixedSize: MaterialStateProperty.all<Size>(const Size(150, 35))),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Close",),
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
            );
          }
          return null;
        },
      ),
    );
  }
}