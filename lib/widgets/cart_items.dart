import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  const CartItem(
      {Key? key,
      required this.title,
      required this.price,
      required this.quantity})
      : super(key: key);
  final String title;
  final double price;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                child: Text('\$$price'),
              ),
            ),
          ),
          title: Text(title),
          subtitle: Text('Total \$${price * quantity}'),
          trailing: Text('$quantity X'),
        ),
      ),
    );
  }
}
