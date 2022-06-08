import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../providers/provider.dart';class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context)?.settings.arguments as String;
    final product = Provider.of<Products>(context).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
    );
  }
}
