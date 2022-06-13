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
  List<OrderItems> orders = [];

  void fetchAndSetOrder() async {
    final url = Uri.parse(
        'https://shopapp-d6ace-default-rtdb.firebaseio.com/orders.json');
    final client = http.Client();
    try {
      final res = await client.get(url);
      if (res.statusCode == 200) {
        if (json.decode(res.body) == null) return;
        final extractedData = json.decode(res.body) as Map<String, dynamic>;
        List<OrderItems> loadedOrders = [];
        extractedData.forEach((orderId, orderData) {
          loadedOrders.add(
            OrderItems(
              id: orderId,
              amount: orderData['amount'],
              dateTime: DateTime.parse(orderData['dateTime']),
              products: (orderData['products'] as List<dynamic>)
                  .map(
                    (item) => CartItem(
                  id: item['id'],
                  price: item['price'],
                  quantity: item['quantity'],
                  title: item['title'],
                ),
              )
                  .toList(),
            ),
          );
        });
        orders = loadedOrders;
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final timeStamp = DateTime.now();
    final body = {
      'amount': total,
      'products': cartProducts
          .map(
            (e) => {
              'id': e.id,
              'title': e.title,
              'price': e.price,
              'quantity': e.quantity,
            },
          )
          .toList(),
      'dateTime': timeStamp.toIso8601String(),
    };
    try {
      final url = Uri.parse(
          'https://shopapp-d6ace-default-rtdb.firebaseio.com/orders.json');
      final client = http.Client();
      final res = await client.post(url, body: json.encode(body));
      print(json.decode(res.body));
      if (res.statusCode == 200 || res.statusCode == 201) {
        orders.insert(
          0,
          OrderItems(
            id: json.decode(res.body)['name'],
            amount: total,
            products: cartProducts,
            dateTime: timeStamp,
          ),
        );
        notifyListeners();
      }
    } catch (error) {
      print(error);
      notifyListeners();
    }
  }
}
