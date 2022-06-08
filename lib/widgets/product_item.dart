import 'package:flutter/material.dart';
import 'package:shop_app/screens/routing/routing.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    void redirectProductDetailScreen() {
      Navigator.of(context).pushNamed(
        Routing.productDetailScreenName,
        arguments: product.id,
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: GestureDetector(
              onTap: ()=> product.toggleIsFavourite(),
              child: Icon(
                Icons.favorite,
                color: product.isFavourite?Theme.of(context).primaryColor: Colors.white,
              )),
          title: Text(product.title),
          trailing: GestureDetector(
              onTap: (){},
              child: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).primaryColor,
              )),
        ),
        child: GestureDetector(
          onTap: () => redirectProductDetailScreen(),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
