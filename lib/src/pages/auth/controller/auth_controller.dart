import 'package:get/get.dart';
import 'package:green_grocer/src/constants/storage_keys.dart';
import 'package:green_grocer/src/models/user_model.dart';
import 'package:green_grocer/src/pages/auth/repository/auth_repository.dart';
import 'package:green_grocer/src/pages/auth/result/auth_result.dart';
import 'package:green_grocer/src/routes/app_pages.dart';
import 'package:green_grocer/src/services/token_servicer.dart';
import 'package:green_grocer/src/services/utils_services.dart';

class AuthController extends GetxController {
  RxBool isFetching = false.obs;

  final authRepository = AuthRepository();
  final UtilsServices utilsServices = UtilsServices();
  final TokenService tokenService = TokenService();

  UserModel user = UserModel(email: '');

  Future<void> validateToken() async {
    // Recuperar o Token salvo localmente
    String? token =
        await tokenService.readData(key: StorageKeys.tokenGreenGrocer);

    if (token == null) {
      Get.offAllNamed(PagesRoutes.signInRoute);
    }
    AuthResult result = await authRepository.validateToken(token!);

    result.when(
      success: (user) {
        this.user = user;
        saveTokenAndProceedToBase();
      },
      error: (message) {
        signOut();
      },
    );
  }

  Future<void> signOut() async {
    // Zerar o user
    user = UserModel(email: '');

    // Remover token Localmente
    await tokenService.removeData(key: StorageKeys.tokenGreenGrocer);

    // Navegar para Login
    Get.offAllNamed(PagesRoutes.signInRoute);
  }

  void saveTokenAndProceedToBase() {
    // Salvar o Token
    tokenService.saveData(key: StorageKeys.tokenGreenGrocer, data: user.token!);

    // Ir para base Screen
    Get.offAllNamed(PagesRoutes.baseRoute);
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

        saveTokenAndProceedToBase();
      },
      error: (message) {
        // print(message);
        utilsServices.showToast(message: message, isError: true);
      },
    );
  }
}
