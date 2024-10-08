import 'package:flutter/material.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/header2.dart';
import '../../constants/app_constants.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {

  bool _all = false;
  bool _discounted = false;
  String _status = 'Status';
  String _category = 'Category';
  final List<bool> _selected = List.generate(10, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header2(text: "Wishlist"),
      body: ListView(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for something...',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min, // Ensures the row takes up only as much space as its children require
            children: <Widget>[
              const SizedBox(width: 5),
              FilterChip(
                label: const Text('All'),
                selected: _all,
                onSelected: (bool value) {
                  setState(() {
                    _all = value;
                  });
                },
              ),
              const SizedBox(width: 5),
              FilterChip(
                label: const Text('Discounted'),
                selected: _discounted,
                onSelected: (bool value) {
                  setState(() {
                    _discounted = value;
                  });
                },
              ),
              const SizedBox(width: 5),
              DropdownButton<String>(
                value: _status,
                onChanged: (String? newValue) {
                  setState(() {
                    _status = newValue!;
                  });
                },
                items: <String>['Status', 'Available', 'Unavailable']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              DropdownButton<String>(
                value: _category,
                onChanged: (String? newValue) {
                  setState(() {
                    _category = newValue!;
                  });
                },
                items: <String>['Category', 'Category 1', 'Category 2']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                // ignore: prefer_typing_uninitialized_variables
                var onAddtoCart;
                return Card(
                  child: Column(
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Image.asset('assets/images/BestSellerWayfarer.jpg'),
                          IconButton(
                            icon: Icon(
                              _selected[index] ? Icons.favorite : Icons.favorite_border,
                              color: _selected[index] ? Colors.red : null,
                            ),
                            onPressed: () {
                              setState(() {
                                _selected[index] = !_selected[index];
                              });
                            },
                          ),
                        ],
                      ),Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Wayfarer Sunglasses', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),),
                              Text('Wayfarer Sunglasses', style: TextStyle(fontWeight: FontWeight.w400,fontSize: 9.0),),
                              Row(
                                children: <Widget>[
                                  Text(
                                    '₱2,999',
                                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12.0),
                                  ),
                                  SizedBox(width: 5),  // Adjust for desired spacing
                                  Text(
                                    '₱3,999',
                                    style: TextStyle(fontSize: 10.0, decoration: TextDecoration.lineThrough),
                                  ),
                                ],
                              )

                            ],
                          ),
                          Container(
                            width: 40,  // Adjust width as needed
                            height: 40,
                            color: Colors.black,// Adjust height as needed
                            child: ElevatedButton(
                              onPressed: onAddtoCart,
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            child: SizedBox(
                              width: 20,
                              height: 20,
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
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Center(
            child: SizedBox(
              width: 200,  // Adjust width as needed
              height: 50,  // Adjust height as needed
              child: ElevatedButton(
                onPressed: () {
                  // Add all to bag
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black),  // Background color
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),  // Rounded corners
                    ),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Icon(Icons.add, color: Colors.white),  // Plus icon
                    SizedBox(width: 10),  // Space between icon and text
                    Text('Add All to Bag', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
