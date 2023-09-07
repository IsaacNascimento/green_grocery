import 'package:get/get.dart';
import 'package:green_grocer/src/constants/storage_keys.dart';
import 'package:green_grocer/src/models/cart/cart_item_model.dart';
import 'package:green_grocer/src/pages/cart/repository/cart_respository.dart';
import 'package:green_grocer/src/pages/cart/result/cart_result.dart';
import 'package:green_grocer/src/services/token_servicer.dart';
import 'package:green_grocer/src/services/utils_services.dart';

class CartController extends GetxController {
  // Variables
  bool isFetching = false;
  List<CartItemModel> cartItems = [];

  // Instances
  final CartRepository cartRepository = CartRepository();
  final TokenService tokenService = TokenService();
  final UtilsServices utilsService = UtilsServices();

  @override
  void onInit() {
    super.onInit();
    getCartItems();
  }

  void setLoading({required bool isLoading}) {
    isFetching = isLoading;
    update();
  }

  Future<void> getCartItems() async {
    setLoading(isLoading: true);

    String? userId = await tokenService.readData(key: StorageKeys.userId);
    String? token =
        await tokenService.readData(key: StorageKeys.tokenGreenGrocer);

    final CartResult<List<CartItemModel>> result =
        await cartRepository.getCartItems(
      token: token!,
      userId: userId!,
    );

    setLoading(isLoading: false);

    result.when(
      success: (data) {
        // print('data $data');
        cartItems = data;
        update();
      },
      error: (message) {
        print(message);
        utilsService.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }
}
