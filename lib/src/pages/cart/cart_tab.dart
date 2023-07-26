import 'package:flutter/material.dart';
import 'package:green_grocer/src/config/custom_colors.dart';
import 'package:green_grocer/src/pages/cart/components/cart_tile.dart';
import 'package:green_grocer/src/services/utils_services.dart';
import 'package:green_grocer/src/config/app_data.dart' as app_data;

class CartTab extends StatelessWidget {
  CartTab({super.key});

  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: app_data.cartItems.length,
              itemBuilder: (_, index) {
                return CartTile(cartItem: app_data.cartItems[index]);
              },
            ),
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
                Text(
                  utilsServices.priceToCurrency(50.5),
                  style: TextStyle(
                    fontSize: 23,
                    color: CustomColors.customSwatchColor,
                    fontWeight: FontWeight.bold,
                  ),
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
                    onPressed: () {},
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
}
