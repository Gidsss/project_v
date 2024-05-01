import 'package:flutter/material.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/adminfooter.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/header2.dart';


class AddProduct extends StatefulWidget{
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => AddProductState();
}

class AddProductState extends State<AddProduct>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header2(text: "Add Product"),
      body: Column(
        children: [
        Expanded(child: Container()),
        AdminFooter(buttonStatus: [false,true,false,false,false], context: context)
        ]
      )

    );
  }
  
}
