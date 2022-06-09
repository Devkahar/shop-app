import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.removeItem,
  }) : super(key: key);
  final String id;
  final String title;
  final double price;
  final int quantity;
  final Function removeItem;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (_) => removeItem(id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) {
        return showDialog(
          context: context,
          builder: (ctx) =>  AlertDialog(
            title: const Text('Are you shure?'),
            content: const Text('You Want to delete this item'),
            actions: [
              ElevatedButton(
                onPressed: () {
                 Navigator.of(context).pop(false);
                },
                child: const Text(
                  "No",
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text(
                  "Yes",
                ),
              ),
            ],
          ),
        );
      },
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      child: Card(
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
      ),
    );
  }
}
