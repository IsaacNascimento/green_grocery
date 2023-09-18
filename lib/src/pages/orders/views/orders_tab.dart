import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_grocer/src/pages/orders/controller/order_controller.dart';
import 'package:green_grocer/src/pages/orders/views/components/order_tile.dart';

class OrdersTab extends StatefulWidget {
  const OrdersTab({super.key});

  @override
  State<OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  final ordersController = Get.find<OrderController>().getOrdesLists();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      body: GetBuilder<OrderController>(
        builder: (controller) {
          return controller.isFetching
              ? const Center(child: CircularProgressIndicator())
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (_, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemBuilder: (_, index) {
                    return OrderTile(
                      order: controller.orders[index],
                    );
                  },
                  itemCount: controller.orders.length,
                );
        },
      ),
    );
  }
}
