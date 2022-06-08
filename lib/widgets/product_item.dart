import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  const ProductItem(
      {Key? key, required this.id, required this.title, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black54,
         leading: GestureDetector(onTap: (){},child:  Icon(Icons.favorite,color: Theme.of(context).primaryColor,)),
         title: Text(title),
          trailing:  GestureDetector(onTap: (){},child: Icon(Icons.shopping_cart,color: Theme.of(context).primaryColor,)),

        ),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
