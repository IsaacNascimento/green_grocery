import 'package:get/get.dart';
import 'package:green_grocer/src/models/user_model.dart';
import 'package:green_grocer/src/pages/auth/repository/auth_repository.dart';
import 'package:green_grocer/src/pages/auth/result/auth_result.dart';
import 'package:green_grocer/src/routes/app_pages.dart';
import 'package:green_grocer/src/services/utils_services.dart';

class AuthController extends GetxController {
  RxBool isFetching = false.obs;

  final authRepository = AuthRepository();
  final UtilsServices utilsServices = UtilsServices();

  UserModel user = UserModel(email: '');

  Future<void> validateToken() async {
    authRepository.validateToken('token');
  }

  Future<void> signIn(UserModel user) async {
    isFetching.value = true;

    AuthResult response = await authRepository.signIn(
        email: user.email, password: user.password ?? '');

    isFetching.value = false;

    response.when(
      success: (user) {
        // print(user);
        this.user = user;

        Get.offAllNamed(PagesRoutes.baseRoute);
      },
      error: (message) {
        // print(message);
        utilsServices.showToast(message: message, isError: true);
      },
    );
  }
}
