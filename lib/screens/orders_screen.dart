import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order.dart' show Order;
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState(){
    Future.delayed(Duration.zero).then((value){
      Provider.of<Order>(context,listen: false).fetchAndSetOrder();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, i) => OrderItem(order: orderData.orders[i]),
      ),
    );
  }
}
