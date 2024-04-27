import 'package:flutter/material.dart';
import 'package:project_v/widgets/Layout/adminheaderfooter.dart';

class ProductsScreen extends StatefulWidget{
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
  }

class _ProductsScreenState extends State<ProductsScreen>{

  @override
  Widget build(BuildContext context) {
    return AdminHeaderFooter(context: context, body: const Text("Products"), title: "ProductsScreen", buttonStatus: const [false, true, false, false, false]);
  }}

