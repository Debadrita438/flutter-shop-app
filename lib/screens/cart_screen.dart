import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_shop_app/models/cart_item.dart';
import 'package:flutter_shop_app/providers/cart_provider.dart';
import 'package:flutter_shop_app/providers/orders_provider.dart';
import '../widgets/cart_items.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total', style: TextStyle(fontSize: 20)),
                  const Spacer(),
                  Chip(
                    label: Text(
                      '₹ ${cart.totalAmount}',
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .titleMedium
                              ?.color),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  TextButton(
                    onPressed: () {
                      Provider.of<OrderProvider>(context, listen: false)
                          .addOrders(
                        cart.cartItems.values.toList(),
                        cart.totalAmount,
                      );
                      cart.clearCart();
                    },
                    child: const Text('ORDER NOW'),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, i) => CartItems(
                id: cart.itemList[i].id,
                title: cart.itemList[i].title,
                quantity: cart.itemList[i].quantity,
                price: cart.itemList[i].price,
                productId: cart.cartItems.keys.toList()[i],
              ),
              itemCount: cart.itemCount,
            ),
          )
        ],
      ),
    );
  }
}
