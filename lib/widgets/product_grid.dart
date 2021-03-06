import 'package:flutter/material.dart';
import 'package:shop_app/widgets/product_item.dart';
import '../providers/product.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class ProductGride extends StatelessWidget {
  bool selectFavourite;
  ProductGride({Key? key, required this.selectFavourite}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = selectFavourite ? productsData.favouriteItem : productsData
        .items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) =>
          ChangeNotifierProvider.value(
            // builder: (c) => products[i],
            value: products[i],
            child: const ProductItem(
              // products[i].id,
              // products[i].title,
              // products[i].imageUrl,
            ),
          ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}