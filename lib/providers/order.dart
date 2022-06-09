import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import './cart.dart';
class OrderItems {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItems(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime});
}

class Order with ChangeNotifier{
  final uuid = const Uuid();
  final List<OrderItems> orders = [];
  void addOrder(List<CartItem> cartProducts, double total) {
    orders.insert(
      0,
      OrderItems(
        id: uuid.v4(),
        amount: total,
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
