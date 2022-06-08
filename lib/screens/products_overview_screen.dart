import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/widgets/product_grid.dart';
import 'package:shop_app/widgets/product_item.dart';
import '../providers/provider.dart';
import 'package:provider/provider.dart';

enum FilterOption {
  onlyFavourite,
  showAll,
}

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool favouriteSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOption selectVal) {
              if (selectVal == FilterOption.onlyFavourite) {
                setState(() {
                  favouriteSelected = true;
                });
              } else {
                setState(() {
                  favouriteSelected = false;
                });
              }
            },
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: FilterOption.onlyFavourite,
                child: Text('Only Favourite'),
              ),
              PopupMenuItem(
                value: FilterOption.showAll,
                child: Text('Show All'),
              ),
            ],
          )
        ],
      ),
      body: ProductGride(selectFavourite: favouriteSelected),
    );
  }
}
