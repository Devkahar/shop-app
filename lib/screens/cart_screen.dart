import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart' show Cart;
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/screens/routing/routing.dart';
import '../widgets/cart_items.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final cartItems = cart.items.values.toList();
    final order = Provider.of<Order>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Card(
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(fontSize: 20),
                      ),
                      const Spacer(),
                      Chip(
                        backgroundColor: Colors.purple[400],
                        label: Text(
                          '\$ ${cart.totalAmount}',
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: cartItems.isEmpty
                            ? null
                            : () async {
                                setState(() {
                                  isLoading = true;
                                });
                                await order.addOrder(
                                  cartItems,
                                  cart.totalAmount,
                                );
                                cart.clear();
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.of(context).pushNamed(Routing.orderScreenName);
                              },
                        child: const Text(
                          'ORDER NOW',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (ctx, index) => CartItem(
                      id: cartItems[index].id,
                      title: cartItems[index].title,
                      quantity: cartItems[index].quantity,
                      price: cartItems[index].price,
                      removeItem: cart.removeItem),
                  itemCount: cart.totaItems,
                ),
              ),
            ],
          ),
          Visibility(
            visible: isLoading,
            child: Container(
                color: Colors.grey.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator(),
                )),
          ),
        ],
      ),
    );
  }
}
