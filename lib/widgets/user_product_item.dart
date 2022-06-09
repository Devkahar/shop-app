import 'package:flutter/material.dart';
import 'package:shop_app/screens/routing/routing.dart';

class UserProductItem extends StatelessWidget {
  const UserProductItem({Key? key, required this.title, required this.imageUrl})
      : super(key: key);
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {

    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Wrap(
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Routing.editProductScreenName);
            },
            icon: const Icon(Icons.edit),
            color: Colors.purple,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
            color: Theme.of(context).errorColor,
          ),

        ],
      ),
    );
  }
}
