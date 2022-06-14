import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/routing/routing.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final auth = Provider.of<Auth>(context,listen: false);
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
          leading: Consumer<Product>(
            builder: (ctx, product, _) => GestureDetector(
              onTap: () => product.toggleIsFavourite(auth.token,auth.userId),
              child: Icon(
                Icons.favorite,
                color: product.isFavourite
                    ? Theme.of(context).primaryColor
                    : Colors.white,
              ),
            ),
          ),
          title: Text(product.title),
          trailing: GestureDetector(
              onTap: () {
                cart.addItems(product.id, product.title, product.price);
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Item Added To Cart Successfully'),
                    duration: const Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: (){
                        //Delete Item.
                        cart.removeSingleItem(product.id);
                      },
                    ),
                  ),
                );
              },
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
