import 'package:flutter/material.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';

class Routing {
  static const productOverviewScreenName = '/';
  static const productDetailScreenName = '/product-detail';

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