import 'package:flutter/material.dart';
import 'package:project_v/constants/app_constants.dart';
import 'package:project_v/widgets/Layout/headerfooter.dart';
import 'package:project_v/screens/interactions/product/productdetails.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class ProductItem extends StatelessWidget {
  final String imageURL;
  final String name;
  final String price;
  final VoidCallback? onTap;
  final VoidCallback? onAddtoCart;

  const ProductItem({
    Key? key,
    required this.imageURL,
    required this.name,
    required this.price,
    this.onTap,
    this.onAddtoCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HeaderFooter(context: context, body: const Text("Explore"), title: "ExploreScreen", buttonStatus: const [false, true, false, false, false]);
  }}


