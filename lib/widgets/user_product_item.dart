import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/routing/routing.dart';

import '../providers/products.dart';

class UserProductItem extends StatelessWidget {
  const UserProductItem({Key? key,required this.id, required this.title, required this.imageUrl})
      : super(key: key);
  final String id;
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context,listen: false);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Wrap(
        children: [
          IconButton(
            onPressed:(){
              Navigator.of(context).pushNamed(Routing.editProductScreenName,arguments: id);
            },
            icon: const Icon(Icons.edit),
            color: Colors.purple,
          ),
          IconButton(
            onPressed: () {
              products.deleteProduct(id);
            },
            icon: const Icon(Icons.delete),
            color: Theme.of(context).errorColor,
          ),

        ],
      ),
    );
  }
}
