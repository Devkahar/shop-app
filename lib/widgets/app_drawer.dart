import 'package:flutter/material.dart';
import 'package:shop_app/screens/routing/routing.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text("Hey What you are looking for"),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text("Shop"),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(Routing.productOverviewScreenName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text("Orders"),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(Routing.orderScreenName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text("Products"),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(Routing.userProductScreenName);
            },
          ),
        ],
      ),
    );
  }
}
