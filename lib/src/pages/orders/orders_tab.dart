import 'package:flutter/material.dart';
import 'package:green_grocer/src/config/app_data.dart' as app_data;

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (_, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemBuilder: (_, index) {
          return Text(app_data.orders[index].id);
        },
        itemCount: app_data.orders.length,
      ),
    );
  }
}
