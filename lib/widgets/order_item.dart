import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/order.dart' as ord;

class OrderItem extends StatelessWidget {
  final ord.OrderItems order;

  const OrderItem({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${order.amount}'),
            subtitle: Text(
              DateFormat('dd MM yyyy hh:mm').format(order.dateTime),
            ),
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
