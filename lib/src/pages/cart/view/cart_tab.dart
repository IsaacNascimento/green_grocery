import 'package:flutter/material.dart';
import 'package:green_grocer/src/config/custom_colors.dart';
import 'package:green_grocer/src/pages/base/controller/navigation_controller.dart';
import 'package:green_grocer/src/pages/cart/view/components/cart_tile.dart';
import 'package:green_grocer/src/pages/widgets/payment_dialog.dart';
import 'package:green_grocer/src/services/utils_services.dart';
import 'package:green_grocer/src/config/app_data.dart' as app_data;
import 'package:green_grocer/src/pages/cart/controller/cart_controller.dart';
import 'package:get/get.dart';

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final UtilsServices utilsServices = UtilsServices();
  final cartController = Get.find<CartController>().getCartItems();
  final _navigateController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: Column(
        children: [
          GetBuilder<CartController>(
            builder: (controller) {
              return controller.isFetching
                  ? const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Expanded(
                      child: Visibility(
                        visible: (controller.cartItems).isNotEmpty,
                        replacement: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.remove_shopping_cart_sharp,
                              size: 30,
                              color: CustomColors.customSwatchColor,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Não há produtos adicionados no Carrinho',
                            ),
                            TextButton(
                              onPressed: () {
                                _navigateController
                                    .navigatePageView(NavigationTabas.home);
                              },
                              child: const Text('Explorar Loja'),
                            ),
                          ],
                        ),
                        child: ListView.builder(
                          itemCount: controller.cartItems.length,
                          itemBuilder: (_, index) {
                            return CartTile(
                              cartItem: controller.cartItems[index],
                            );
                          },
                        ),
                      ),
                    );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade100,
                  blurRadius: 3,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Total geral',
                  style: TextStyle(fontSize: 12),
                ),
                GetBuilder<CartController>(
                  builder: ((controller) {
                    return Text(
                      utilsServices
                          .priceToCurrency(controller.cartTotalPrice()),
                      style: TextStyle(
                        fontSize: 23,
                        color: CustomColors.customSwatchColor,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.customSwatchColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () async {
                      bool? result = await showOrderConfirmation();

                      if (result ?? false) {
                        if (!mounted) return;
                        showDialog(
                            context: context,
                            builder: (_) {
                              return PaymentDialog(
                                  order: app_data.orders.first);
                            });
                      } else {
                        utilsServices.showToast(
                            message: 'Pedido não confirmado', isError: true);
                      }
                    },
                    child: const Text(
                      'Concluir Pedido',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> showOrderConfirmation() {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text('Confirmação'),
            content: const Text('Desejar realmente concluir o Pedido?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('Não'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Sim'),
              ),
            ],
          );
        });
  }
}
