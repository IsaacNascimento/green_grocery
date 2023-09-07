import 'package:get/get.dart';
import 'package:green_grocer/src/constants/storage_keys.dart';
import 'package:green_grocer/src/models/user/user_model.dart';
import 'package:green_grocer/src/pages/auth/repository/auth_repository.dart';
import 'package:green_grocer/src/pages/auth/result/auth_result.dart';
import 'package:green_grocer/src/routes/app_pages.dart';
import 'package:green_grocer/src/services/token_servicer.dart';
import 'package:green_grocer/src/services/utils_services.dart';

class AuthController extends GetxController {
  RxBool isFetching = false.obs;
  RxBool isFetchingResetPassword = false.obs;

  final authRepository = AuthRepository();
  final UtilsServices utilsServices = UtilsServices();
  final TokenService tokenService = TokenService();

  UserModel currentUser = UserModel(email: '');

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
        currentUser = user;
        saveTokenAndProceedToBase();
      },
      error: (message) {
        signOut();
      },
    );
  }

  Future<void> signOut() async {
    // Zerar o user
    currentUser = UserModel(email: '');

    // Remover token Localmente
    await tokenService.removeData(key: StorageKeys.tokenGreenGrocer);

    // Remover userId Localmente
    await tokenService.removeData(key: StorageKeys.userId);

    // Navegar para Login
    Get.offAllNamed(PagesRoutes.signInRoute);
  }

  void saveTokenAndProceedToBase() {
    // Salvar o Token
    tokenService.saveData(
        key: StorageKeys.tokenGreenGrocer, data: currentUser.token!);

    // Salvar o userId
    tokenService.saveData(key: StorageKeys.userId, data: currentUser.id!);

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
        currentUser = user;

        saveTokenAndProceedToBase();
      },
      error: (message) {
        // print(message);
        utilsServices.showToast(message: message, isError: true);
      },
    );
  }

  Future<void> signUp() async {
    isFetching.value = true;

    // print('user controller: $user');

    AuthResult response = await authRepository.signUp(currentUser);

    isFetching.value = false;

    response.when(
      success: (user) {
        currentUser = user;

        saveTokenAndProceedToBase();
      },
      error: (message) {
        utilsServices.showToast(message: message, isError: true);
      },
    );
  }

  Future<void> resetPassword({required String email}) async {
    isFetchingResetPassword.value = true;

    AuthResult response = await authRepository.resetPassword(email: email);

    isFetchingResetPassword.value = false;

    response.when(
      success: (user) {
        // this.user = user;
        utilsServices.showToast(
          message: 'Link de recuperação enviado para $email',
        );
      },
      error: (message) {
        utilsServices.showToast(message: message, isError: true);
      },
    );
  }
}
