import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // one way
    // return Consumer<Product>(
    //   builder: (ctx, product, child) => ClipRRect(
    //     borderRadius: BorderRadius.circular(10),
    //     child: GridTile(
    //       footer: GridTileBar(
    //         backgroundColor: Colors.black54,
    //         leading: IconButton(
    //           icon: Icon(
    //             product.isFavorite ? Icons.favorite : Icons.favorite_border,
    //           ),
    //           onPressed: () {
    //             product.toggleFavoriteStatus();
    //           },
    //           color: Theme.of(context).colorScheme.secondary,
    //         ),
    //         title: Text(
    //           product.title,
    //           textAlign: TextAlign.center,
    //         ),
    //         trailing: IconButton(
    //           icon: const Icon(Icons.shopping_cart),
    //           onPressed: () {},
    //           color: Theme.of(context).colorScheme.secondary,
    //         ),
    //       ),
    //       child: GestureDetector(
    //         onTap: () {
    //           Navigator.of(context).pushNamed(
    //             ProductDetailScreen.routeName,
    //             arguments: product.id,
    //           );
    //         },
    //         child: Image.network(
    //           product.imageUrl,
    //           fit: BoxFit.cover,
    //         ),
    //       ),
    //     ),
    //   ),
    // );

    // other way
    final product = Provider.of<Product>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
              onPressed: () {
                product.toggleFavoriteStatus();
              },
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
