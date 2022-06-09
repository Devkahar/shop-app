import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';
import 'package:shop_app/screens/routing/routing.dart';
import 'package:provider/provider.dart';
import './providers/provider.dart';
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

        ChangeNotifierProvider.value(value: Products(),),
        ChangeNotifierProvider.value(value: Cart(),),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          primaryColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        // onGenerateRoute: Routing.onGenerateRoute,
        routes: {
        Routing.productOverviewScreenName: (ctx)=> const ProductsOverviewScreen(),
          Routing.productDetailScreenName: (ctx)=>  const ProductDetailScreen(),
          Routing.cartScreenName: (ctx)=> const CartScreen(),
        },
      ),
    );
  }
}