import 'package:flutter/material.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';

class Routing {
  static const productOverviewScreenName = '/';
  static const productDetailScreenName = '/product-detail';
  static const cartScreenName = '/cart';
  static const orderScreenName = '/order';
  static const userProductScreenName = '/user-product';

  static MaterialPageRoute? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case productOverviewScreenName:
        return MaterialPageRoute(
          builder: (context) => ProductsOverviewScreen(),
        );
      case productDetailScreenName:
        return MaterialPageRoute(
          builder: (context) => const ProductDetailScreen(),
        );
      case cartScreenName:
        return MaterialPageRoute(
          builder: (context) => const CartScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('Undefined route'),
            ),
          ),
        );
    }
  }
}
