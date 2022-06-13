import 'package:flutter/material.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/screens/auth_screen.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/product_edit_screen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';
import 'package:shop_app/screens/routing/routing.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/user_product_screen.dart';
import './providers/products.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Order(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          primaryColor: Colors.deepOrange,
          fontFamily: 'Lato',
          textTheme: const TextTheme(
            titleLarge: TextStyle(color: Colors.white),
          ),
        ),
        debugShowCheckedModeBanner: false,
        // onGenerateRoute: Routing.onGenerateRoute,
        routes: {
          Routing.productOverviewScreenName: (ctx) =>
              const ProductsOverviewScreen(),
          Routing.authScreen: (ctx) => const AuthScreen(),
          Routing.productDetailScreenName: (ctx) => const ProductDetailScreen(),
          Routing.cartScreenName: (ctx) => const CartScreen(),
          Routing.orderScreenName: (ctx) => OrdersScreen(),
          Routing.userProductScreenName: (ctx) => const UserProductScreen(),
          Routing.editProductScreenName: (ctx) => const ProductEditScreen(),
        },
      ),
    );
  }
}
