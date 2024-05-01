import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_v/constants/app_constants.dart';
import 'package:project_v/screens/customer/appointment/schedulescreen.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/adminfooter.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/header2.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:project_v/widgets/CustomWidgets/labelHeader.dart';
import 'package:project_v/widgets/textfields/textfield2.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => AddProductState();
}

class AddProductState extends State<AddProduct> {
  bool exists = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: Header2(text: "Add Product"),
        body: Column(children: [
          Expanded(
              child: SingleChildScrollView(
                child: Container(
                    child: Column(children: [
                            SizedBox(
                height: 20,
                            ),
                            CarouselSlider(
                options: CarouselOptions(
                  initialPage: 1,
                  enableInfiniteScroll: false,
                  viewportFraction: 0.5,
                  height: MediaQuery.of(context).size.height * 0.30,
                  enlargeCenterPage: true),
                items: [
                  createSliderItem(context),
                  createSliderItem(context),
                  createSliderItem(context)
                ],
                            ),
                            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Product Name", style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 5,),
                    createField(MediaQuery.of(context).size.width * 1, 0,"Galataire", 1, 1),
                    SizedBox(height: 15,),
                    Text("Product Description", style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 5,),
                    createField(MediaQuery.of(context).size.width * 1, 40 ,"Description", 5, null),
                    SizedBox(height: 15,),
                    Text("Product Price", style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 5,),
                    createField(MediaQuery.of(context).size.width * 1, 0,"₱ 6,000", 1, 1),
                    SizedBox(height: 15,),
                    Text("Product Color", style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 5,),
                    createField(MediaQuery.of(context).size.width * 1, 0,"Black", 1, 1),
                    SizedBox(height: 15,),
                    Text("Product Quantity", style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 5,),
                    createField(MediaQuery.of(context).size.width * 1, 0,"15", 1, 1),
                
                  ],
                ),
                            )
                          ])),
              )),
          AdminFooter(
              buttonStatus: [false, true, false, false, false],
              context: context)
        ]));
  }
}

Widget createSliderItem(BuildContext context) {
  return Stack(children: [
    Container(
      width: MediaQuery.of(context).size.width * 0.50,
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              offset: Offset(2, 2),
              blurRadius: 3,
              spreadRadius: 2)
        ],
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
            image: AssetImage("assets/images/product_1.jpg"),
            fit: BoxFit.contain),
      ),
    ),
    IconButton(
        onPressed: () {},
        tooltip: "Add more Images",
        icon: Icon(
          Icons.add_circle,
          color: Colors.black,
          size: 30,
        ))
  ]);
}

Widget createField(double width, double height, String text, int? minlines, int? maxlines){
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
    ),
    height: 40 + height,
    width: width,
    child: Expanded(
      flex: 2,
      child: TextFormField(
        minLines: minlines,
        maxLines: maxlines,
        style: const TextStyle(fontSize: 14, height: 1),
        onSaved: (String? value) {},
        validator: (value) {
          return null;
        },
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: text,
            hintStyle: const TextStyle(fontSize: 14, height: 1),
            contentPadding: const EdgeInsets.fromLTRB(8, 10, 8, 10)),
      ),
    ),
  );
}