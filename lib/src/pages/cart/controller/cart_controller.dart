import 'package:get/get.dart';
import 'package:green_grocer/src/constants/storage_keys.dart';
import 'package:green_grocer/src/pages/cart/repository/cart_respository.dart';
import 'package:green_grocer/src/pages/cart/result/cart_result.dart';
import 'package:green_grocer/src/services/token_servicer.dart';

class CartController extends GetxController {
  bool isFetching = false;

  final CartRepository cartRepository = CartRepository();
  final TokenService tokenService = TokenService();

  @override
  void onInit() {
    super.onInit();

    getCartItems();
  }

  Future<void> getCartItems() async {
    isFetching = true;

    String? userId = await tokenService.readData(key: StorageKeys.userId);
    String? token =
        await tokenService.readData(key: StorageKeys.tokenGreenGrocer);

    final CartResult result = await cartRepository.getCartItems(
      token: token!,
      userId: userId!,
    );

    isFetching = false;

    result.when(
      success: (data) {
        print(data);
      },
      error: (error) {
        print(error);
      },
    );
  }
}
