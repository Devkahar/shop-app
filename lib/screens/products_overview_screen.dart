import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/widgets/product_grid.dart';
import 'package:shop_app/widgets/product_item.dart';

class ProductsOverviewScreen extends StatelessWidget {
  const ProductsOverviewScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'),
      ),
      body: ProductGride(),
    );
  }
}
