import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_grocer/src/config/custom_colors.dart';
import 'package:green_grocer/src/models/cart/cart_item_model.dart';
import 'package:green_grocer/src/pages/cart/controller/cart_controller.dart';
import 'package:green_grocer/src/pages/widgets/quantity_widgets.dart';
import 'package:green_grocer/src/routes/app_pages.dart';
import 'package:green_grocer/src/services/utils_services.dart';

class CartTile extends StatefulWidget {
  final CartItemModel cartItem;

  const CartTile({super.key, required this.cartItem});

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  final UtilsServices utilsServices = UtilsServices();
  final _controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        // imagem
        leading: GestureDetector(
          onTap: () {
            Get.toNamed(PagesRoutes.productRoute,
                arguments: widget.cartItem.item);
          },
          child: Image.network(
            widget.cartItem.item.picture,
            height: 60,
            width: 60,
          ),
        ),

        // Titulo
        title: Text(
          widget.cartItem.item.title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),

        // Total
        subtitle: Text(
          utilsServices.priceToCurrency(widget.cartItem.totalPrice()),
          style: TextStyle(
            color: CustomColors.customSwatchColor,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Quantidade
        trailing: QuantityWidget(
          value: widget.cartItem.quantity,
          suffixText: widget.cartItem.item.unit,
          result: (quantity) {
            _controller.modifyItemQuantity(
              quantity: quantity,
              cartItem: widget.cartItem,
            );
          },
          isRemovable: true,
        ),
      ),
    );
  }
}
