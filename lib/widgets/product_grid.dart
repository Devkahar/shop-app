import 'package:flutter/material.dart';
import 'package:shop_app/widgets/product_item.dart';
import '../providers/product.dart';
import 'package:provider/provider.dart';
import '../providers/provider.dart';

class ProductGride extends StatelessWidget {
  bool selectFavourite;
  ProductGride({Key? key, required this.selectFavourite}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Product> loadedProduct = selectFavourite?Provider.of<Products>(context).favouriteItem: Provider.of<Products>(context).items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
       value: loadedProduct[i],
        child: ProductItem(),
      ),
      itemCount: loadedProduct.length,
    );
  }
}
