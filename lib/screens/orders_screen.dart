import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders_provider.dart';

class MyWidget extends StatelessWidget {
  MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<OrderProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      // body: ListView.builder(itemBuilder: itemBuilder),
    );
  }
}
