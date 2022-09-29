import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartItems extends StatelessWidget {
  final String id;
  final double price;
  final String title;
  final int quantity;
  final String productId;

  const CartItems({
    super.key,
    required this.id,
    required this.price,
    required this.title,
    required this.quantity,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) =>
          Provider.of<CartProvider>(context, listen: false)
              .removeItem(productId),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(
                  child: Text(
                    '₹ ${price}',
                  ),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: ₹ ${price * quantity}'),
            trailing: Text('X $quantity'),
          ),
        ),
      ),
    );
  }
}
