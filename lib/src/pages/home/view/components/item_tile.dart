import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_grocer/src/config/custom_colors.dart';
import 'package:green_grocer/src/models/product/product_item_model.dart';
import 'package:green_grocer/src/pages/cart/controller/cart_controller.dart';
import 'package:green_grocer/src/routes/app_pages.dart';
import 'package:green_grocer/src/services/utils_services.dart';

class ItemTile extends StatelessWidget {
  final ProductItemModel item;
  final void Function(GlobalKey) cartAnimationMethod;
  final GlobalKey imageGk = GlobalKey();

  ItemTile({
    super.key,
    required this.item,
    required this.cartAnimationMethod,
  });

  final UtilsServices utilsServices = UtilsServices();
  final _cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Conteúdo
        GestureDetector(
          onTap: () {
            Get.toNamed(PagesRoutes.productRoute, arguments: item);
          },
          child: Card(
            elevation: 1,
            shadowColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Imagem
                  Expanded(
                    child: Hero(
                      tag: item.picture,
                      child: Image.network(item.picture, key: imageGk),
                    ),
                  ),

                  // Nome
                  Text(
                    item.title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  // Preço - Unidade
                  Row(
                    children: [
                      Text(
                        utilsServices.priceToCurrency(item.price),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: CustomColors.customSwatchColor,
                        ),
                      ),
                      Text(
                        '/${item.unit}',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),

        // Botão add Carrinho
        Positioned(
          top: 4,
          right: 4,
          child: GetBuilder<CartController>(
            builder: (controller) {
              return GestureDetector(
                onTap: controller.isFetching
                    ? null
                    : () async {
                        cartAnimationMethod(imageGk);

                        await _cartController.addItemToCart(item: item);
                      },
                child: Container(
                  decoration: BoxDecoration(
                    color: CustomColors.customSwatchColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  height: 40,
                  width: 35,
                  child: const Icon(Icons.add_shopping_cart_outlined,
                      color: Colors.white, size: 20),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
