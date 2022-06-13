import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/routing/routing.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/product_grid.dart';
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
  bool _inti = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_inti) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProduct().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
      print("Yes");
    }
    _inti = false;
    super.didChangeDependencies();
  }

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
          ),
          Consumer<Cart>(
            builder: (_, cart, __) => GestureDetector(
              onTap: () =>
                  Navigator.of(context).pushNamed(Routing.cartScreenName),
              child: Badge(
                value: cart.items.length.toString(),
                child: const Icon(Icons.shopping_cart),
              ),
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProductGride(selectFavourite: favouriteSelected),
    );
  }
}
