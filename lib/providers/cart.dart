import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price});
}

class Cart with ChangeNotifier {
  final uuid = const Uuid();
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get totaItems {
    return _items.length;
  }

  void addItems(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      //.. Change qty;
      _items.update(
          productId,
          (oldItem) => CartItem(
              id: oldItem.id,
              title: oldItem.title,
              quantity: oldItem.quantity + 1,
              price: oldItem.price));
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: uuid.v4(),
          title: title,
          quantity: 1,
          price: price,
        ),
      );
    }
    notifyListeners();
  }
}
