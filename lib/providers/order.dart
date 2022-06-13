import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import './cart.dart';

class OrderItems {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItems({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Order with ChangeNotifier {
  final uuid = const Uuid();
  final List<OrderItems> orders = [];

  void addOrder(List<CartItem> cartProducts, double total) async {
    final orderItem = OrderItems(
      id: uuid.v4(),
      amount: total,
      products: cartProducts,
      dateTime: DateTime.now(),
    );
    final body = {
      'amount': total.toString(),
      'products': cartProducts.toList(),
      'dateTime': DateTime.now(),
    };
    try {
      final url = Uri.parse(
          'https://shopapp-d6ace-default-rtdb.firebaseio.com/orders.json');
      final client = http.Client();
      final res = await client.post(url, body: body);
      print(json.decode(res.body));
      orders.insert(
        0,
        orderItem,
      );
      notifyListeners();
    } catch (error) {
      print(error);
      notifyListeners();
    }
  }
}
