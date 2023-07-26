import 'package:flutter/material.dart';
import 'package:green_grocer/src/config/custom_colors.dart';
import 'package:green_grocer/src/models/cart_item_model.dart';
import 'package:green_grocer/src/pages/widgets/quantity_widgets.dart';
import 'package:green_grocer/src/services/utils_services.dart';

class CartTile extends StatelessWidget {
  final CartItemModel cartItem;

  CartTile({super.key, required this.cartItem});

  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        // imagem
        leading: Image.asset(
          cartItem.item.imgUrl,
          height: 60,
          width: 60,
        ),

        // Titulo
        title: Text(
          cartItem.item.itemName,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),

        // Total
        subtitle: Text(
          utilsServices.priceToCurrency(cartItem.totalPrice()),
          style: TextStyle(
            color: CustomColors.customSwatchColor,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Quantidade
        trailing: QuantityWidget(
            value: cartItem.quantity,
            suffixText: cartItem.item.unit,
            result: (quantity) {}),
      ),
    );
  }
}
