import 'package:get/get.dart';
import 'package:green_grocer/src/constants/storage_keys.dart';
import 'package:green_grocer/src/models/cart/cart_item_model.dart';
import 'package:green_grocer/src/models/product/product_item_model.dart';
import 'package:green_grocer/src/pages/cart/repository/cart_respository.dart';
import 'package:green_grocer/src/pages/cart/result/cart_result.dart';
import 'package:green_grocer/src/services/token_servicer.dart';
import 'package:green_grocer/src/services/utils_services.dart';

class CartController extends GetxController {
  // Gloabal Variables
  bool isFetching = false;
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

  void _setLoading({required bool isLoading}) {
    isFetching = isLoading;
    update();
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
    _setLoading(isLoading: true);

    await _getUserValues();

    final CartResult<List<CartItemModel>> result =
        await _cartRepository.getCartItems(
      token: _token!,
      userId: _userId!,
    );

    _setLoading(isLoading: false);

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
    return cartItems.indexWhere((itemInList) => itemInList.id == item.id);
  }

  Future<void> addItemToCart(
      {required ProductItemModel item, int quantity = 1}) async {
    int itemIndex = _getItemIndex(item);

    if (itemIndex >= 0) {
      // Item Já existe no carrinho

      cartItems[itemIndex].quantity += quantity;
    } else {
      // Novo item;

      cartItems.add(
        CartItemModel(
          id: '',
          item: item,
          quantity: quantity,
        ),
      );

      final CartResult<String> result = await _cartRepository.addItemToCart(
        token: _token!,
        userId: _userId!,
        quantity: quantity,
        productId: item.id,
      );

      result.when(
        success: (data) {
          print('(addItemToCart) data: $data');
        },
        error: (error) {
          print('(addItemToCart) error: $error');
          _utilsService.showToast(message: error, isError: true);
        },
      );
    }
    update();
  }
}
