import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../screens/cart_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/badge.dart';
import '../widgets/products_grid.dart';
import '../providers/products_provider.dart';

enum FilterOptions {
  favorites,
  all,
}

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showFavoritesOnly = false;
  var _isInit = true;
  var _isLoading = false;

  // @override
  // void initState() {
  //   // Provider.of<ProductsProvider>(context).fetchProducts();
  //   // Future.delayed(Duration.zero).then((_) => Provider.of<ProductsProvider>(context).fetchProducts());
  // }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() => _isLoading = true);

      Provider.of<ProductsProvider>(context).fetchProducts().then((_) {
        setState(() => _isLoading = false);
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shoppie'),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.favorites,
                child: Text('Only Favorites'),
              ),
              const PopupMenuItem(
                value: FilterOptions.all,
                child: Text('Show All'),
              ),
            ],
            icon: const Icon(Icons.more_vert),
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.favorites) {
                  _showFavoritesOnly = true;
                } else {
                  _showFavoritesOnly = false;
                }
              });
            },
          ),
          Consumer<CartProvider>(
            builder: (_, cartData, ch) => Badge(
              value: cartData.itemCount.toString(),
              child: ch!,
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          )
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ProductGrid(showOnlyFavorites: _showFavoritesOnly),
      drawer: AppDrawer(),
    );
  }
}
