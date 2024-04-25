import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../chat/chatdetailscreen.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {

  bool _all = false;
  bool _discounted = false;
  String _status = 'Status';
  String _category = 'Category';
  List<bool> _selected = List.generate(10, (index) => false);

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
            "Wishlist",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          preferredSize: Size.zero,
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min, // Ensures the row takes up only as much space as its children require
            children: <Widget>[
              FilterChip(
                label: Text('All'),
                selected: _all,
                onSelected: (bool value) {
                  setState(() {
                    _all = value;
                  });
                },
              ),
              SizedBox(width: 15),
              FilterChip(
                label: Text('Discounted'),
                selected: _discounted,
                onSelected: (bool value) {
                  setState(() {
                    _discounted = value;
                  });
                },
              ),
              SizedBox(width: 15),
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
              SizedBox(width: 15),
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
          Container(
            height: MediaQuery.of(context).size.height,
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: 4,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (BuildContext context, int index) {
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
                          Column(
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
            child: Container(
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
