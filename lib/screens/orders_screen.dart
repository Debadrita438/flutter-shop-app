import 'package:flutter/material.dart';
import 'package:flutter_shop_app/widgets/app_drawer.dart';
import 'package:flutter_shop_app/widgets/order_items.dart';
import 'package:provider/provider.dart';

import '../providers/orders_provider.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late Future _ordersFuture;

  Future _obtainOrdersFuture() {
    return Provider.of<OrderProvider>(context, listen: false).fetchOrders();
  }

  @override
  void initState() {
    _ordersFuture = _obtainOrdersFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      body: FutureBuilder(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.connectionState == ConnectionState.done) {
              return Consumer<OrderProvider>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (ctx, i) =>
                      OrderItems(order: orderData.orders[i]),
                ),
              );
            } else {
              return Center(
                child: Text('An error occured!'),
              );
            }
          }
        },
      ),
      drawer: AppDrawer(),
    );
  }
}
