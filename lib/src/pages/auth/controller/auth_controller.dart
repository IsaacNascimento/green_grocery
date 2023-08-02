import 'package:get/get.dart';
import 'package:green_grocer/src/models/user_model.dart';

class AuthController extends GetxController {
  RxBool isFetching = false.obs;

  Future<void> signIn(UserModel user) async {
    isFetching.value = true;

    await Future.delayed(
      const Duration(milliseconds: 1500),
    );

    isFetching.value = false;
  }
}
