import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/routing/routing.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final products = Provider.of<Products>(context).items;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Products'),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).pushNamed(Routing.editProductScreenName);
          }, icon: const Icon(Icons.add),),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemBuilder: (_, index) => Column(
            children: [
              UserProductItem(
                id: products[index].id,
                imageUrl: products[index].imageUrl,
                title: products[index].title,
              ),
              const Divider(),
            ],
          ),
          itemCount: products.length,
        ),
      ),
      drawer: const AppDrawer(),
    );
  }
}
