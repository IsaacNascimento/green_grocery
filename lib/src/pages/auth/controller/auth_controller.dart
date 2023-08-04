import 'package:get/get.dart';
import 'package:green_grocer/src/models/user_model.dart';
import 'package:green_grocer/src/pages/auth/repository/auth_repository.dart';
import 'package:green_grocer/src/pages/auth/result/auth_result.dart';

class AuthController extends GetxController {
  RxBool isFetching = false.obs;

  final authRepository = AuthRepository();

  Future<void> signIn(UserModel user) async {
    isFetching.value = true;

    AuthResult response = await authRepository.signIn(
        email: user.email, password: user.password ?? '');

    isFetching.value = false;

    response.when(
      success: (user) {
        print(user);
      },
      error: (message) {
        print(message);
      },
    );
  }
}
