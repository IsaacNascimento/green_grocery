import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_grocer/src/constants/storage_keys.dart';
import 'package:green_grocer/src/models/cart/cart_item_model.dart';
import 'package:green_grocer/src/models/order/order_item_model.dart';
import 'package:green_grocer/src/models/product/product_item_model.dart';
import 'package:green_grocer/src/pages/cart/repository/cart_respository.dart';
import 'package:green_grocer/src/pages/cart/result/cart_result.dart';
import 'package:green_grocer/src/services/token_servicer.dart';
import 'package:green_grocer/src/services/utils_services.dart';

import '../../widgets/payment_dialog.dart';

abstract class LoadingsNames {
  static const String isFetching = 'FETCHING';
  static const String isQuantity = 'QUANTITY';
  static const String isCheckout = 'CHECKOUT';
}

class CartController extends GetxController {
  // Global Variables
  bool isFetching = false;
  bool isQuantityChange = false;
  bool isCheckoutLoading = false;
  String cartIdSelectedToModify = '';
  List<CartItemModel> cartItems = [];

  // Private Instances
  final CartRepository _cartRepository = CartRepository();
  final TokenService _tokenService = TokenService();
  final UtilsServices _utilsService = UtilsServices();

  // Private Variables
  String? _userId;
  String? _token;

  @override
  void onInit() {
    super.onInit();
    getCartItems();
    cartTotalPrice();
  }

  void _setLoading({required bool isLoading, required String loadingName}) {
    switch (loadingName) {
      case LoadingsNames.isFetching:
        isFetching = isLoading;
        update();
        break;
      case LoadingsNames.isQuantity:
        isQuantityChange = isLoading;
        update();
        break;
      case LoadingsNames.isCheckout:
        isCheckoutLoading = isLoading;
        update();
        break;
      default:
        '';
    }
  }

  Future<void> _getUserValues() async {
    _userId = await _tokenService.readData(key: StorageKeys.userId);
    _token = await _tokenService.readData(key: StorageKeys.tokenGreenGrocer);
  }

  double cartTotalPrice() {
    List<CartItemModel> cartItemModel = cartItems;
    int cartItemLenght = cartItemModel.length;
    double totalPrice = 0;

    for (var i = 0; i < cartItemLenght; i++) {
      totalPrice += cartItemModel[i].totalPrice();
    }

    return totalPrice;
  }

  Future<void> getCartItems() async {
    _setLoading(isLoading: true, loadingName: LoadingsNames.isFetching);

    await _getUserValues();

    final CartResult<List<CartItemModel>> result =
        await _cartRepository.getCartItems(
      token: _token!,
      userId: _userId!,
    );

    _setLoading(isLoading: false, loadingName: LoadingsNames.isFetching);

    result.when(
      success: (data) {
        // print('data $data');
        cartItems = data;
        update();
      },
      error: (message) {
        print(message);
        _utilsService.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }

  int _getItemIndex(ProductItemModel item) {
    return cartItems.indexWhere((itemInList) => itemInList.item.id == item.id);
  }

  Future<void> addItemToCart({
    required ProductItemModel item,
    int quantity = 1,
  }) async {
    int itemIndex = _getItemIndex(item);
    // print('item: ${item.title}, itemIndex: $itemIndex');

    if (itemIndex >= 0) {
      // Item Já existe no carrinho

      final CartItemModel cartItem = cartItems[itemIndex];

      await modifyItemQuantity(
        quantity: (cartItem.quantity + quantity),
        cartItem: cartItem,
      );
    } else {
      // Novo item;
      _setLoading(isLoading: true, loadingName: LoadingsNames.isFetching);

      final CartResult<String> result = await _cartRepository.addItemToCart(
        token: _token!,
        userId: _userId!,
        quantity: quantity,
        productId: item.id,
      );

      _setLoading(isLoading: false, loadingName: LoadingsNames.isFetching);

      result.when(
        success: (data) {
          // print('(addItemToCart) data: $data');
          cartItems.add(
            CartItemModel(
              id: data,
              item: item,
              quantity: quantity,
            ),
          );
        },
        error: (error) {
          // print('(addItemToCart) error: $error');
          _utilsService.showToast(message: error, isError: true);
        },
      );
    }
    update();
  }

  Future<bool> modifyItemQuantity({
    required int quantity,
    required CartItemModel cartItem,
  }) async {
    cartIdSelectedToModify = cartItem.id;
    _setLoading(isLoading: true, loadingName: LoadingsNames.isQuantity);
    // print('(cart Controller) Modify quantity: $quantity, CartItem: $cartItem');

    final bool result = await _cartRepository.modifyItemQuantity(
      token: _token!,
      quantity: quantity,
      cartItemId: cartItem.id,
    );

    // print('(cart Controller) result: $result');

    if (result) {
      if (quantity == 0) {
        cartItems.removeWhere((element) => element.id == cartItem.id);
        update();
      } else {
        cartItems.firstWhere((element) => element.id == cartItem.id).quantity =
            quantity;
        update();
      }
    } else {
      String errorMessage = 'Não foi possível modificar a quantidade do item';
      _utilsService.showToast(message: errorMessage, isError: true);
    }

    _setLoading(isLoading: false, loadingName: LoadingsNames.isQuantity);
    // print('2º is Button Enable: $isButtonEnable');

    return result;
  }

  Future checkoutOrder() async {
    _setLoading(isLoading: true, loadingName: LoadingsNames.isCheckout);

    final double totalCartPrice = cartTotalPrice();
    final CartResult<OrderModel> result = await _cartRepository.checkoutOrder(
      token: _token!,
      totalCartPrice: totalCartPrice,
    );

    _setLoading(isLoading: false, loadingName: LoadingsNames.isCheckout);

    result.when(
      success: (data) {
        cartItems.clear();
        update();

        showDialog(
          context: Get.context!,
          builder: (_) {
            return PaymentDialog(order: data);
          },
        );
      },
      error: (error) {
        _utilsService.showToast(
          message: error,
        );
      },
    );
  }
}
