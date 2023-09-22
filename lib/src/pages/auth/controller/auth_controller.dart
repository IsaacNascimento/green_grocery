import 'package:get/get.dart';
import 'package:green_grocer/src/constants/storage_keys.dart';
import 'package:green_grocer/src/models/user/user_model.dart';
import 'package:green_grocer/src/pages/auth/repository/auth_repository.dart';
import 'package:green_grocer/src/pages/auth/result/auth_result.dart';
import 'package:green_grocer/src/routes/app_pages.dart';
import 'package:green_grocer/src/services/token_servicer.dart';
import 'package:green_grocer/src/services/utils_services.dart';

class AuthController extends GetxController {
  // Public Variables
  RxBool isFetching = false.obs;
  RxBool isFetchingResetPassword = false.obs;
  bool isLoadingUser = false;
  UserModel currentUser = UserModel(email: '');

  final _authRepository = AuthRepository();
  final UtilsServices _utilsServices = UtilsServices();
  final TokenService _tokenService = TokenService();

  void _setIsLoading({required bool isLoading}) {
    isLoadingUser = isLoading;
    update();
  }

  Future<void> validateToken({bool navigateToBase = true}) async {
    _setIsLoading(isLoading: true);
    // Recuperar o Token salvo localmente
    String? token =
        await _tokenService.readData(key: StorageKeys.tokenGreenGrocer);

    if (token == null) {
      Get.offAllNamed(PagesRoutes.signInRoute);
    }
    AuthResult result = await _authRepository.validateToken(token!);

    _setIsLoading(isLoading: false);

    result.when(
      success: (user) {
        currentUser = user;
        if (navigateToBase) {
          saveTokenAndProceedToBase();
        }
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
    await _tokenService.removeData(key: StorageKeys.tokenGreenGrocer);

    // Remover userId Localmente
    await _tokenService.removeData(key: StorageKeys.userId);

    // Navegar para Login
    Get.offAllNamed(PagesRoutes.signInRoute);
  }

  void saveTokenAndProceedToBase() {
    // Salvar o Token
    _tokenService.saveData(
        key: StorageKeys.tokenGreenGrocer, data: currentUser.token!);

    // Salvar o userId
    _tokenService.saveData(key: StorageKeys.userId, data: currentUser.id!);

    // Ir para base Screen
    Get.offAllNamed(PagesRoutes.baseRoute);
  }

  Future<void> signIn(UserModel user) async {
    isFetching.value = true;

    AuthResult response = await _authRepository.signIn(
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
        _utilsServices.showToast(message: message, isError: true);
      },
    );
  }

  Future<void> signUp() async {
    isFetching.value = true;

    // print('user controller: $user');

    AuthResult response = await _authRepository.signUp(currentUser);

    isFetching.value = false;

    response.when(
      success: (user) {
        currentUser = user;

        saveTokenAndProceedToBase();
      },
      error: (message) {
        _utilsServices.showToast(message: message, isError: true);
      },
    );
  }

  Future<void> resetPassword({required String email}) async {
    isFetchingResetPassword.value = true;

    AuthResult response = await _authRepository.resetPassword(email: email);

    isFetchingResetPassword.value = false;

    response.when(
      success: (user) {
        // this.user = user;
        _utilsServices.showToast(
          message: 'Link de recuperação enviado para $email',
        );
      },
      error: (message) {
        _utilsServices.showToast(message: message, isError: true);
      },
    );
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    isFetching.value = true;

    final response = await _authRepository.changePassword(
      email: currentUser.email,
      currentPassword: currentPassword,
      newPassword: newPassword,
    );

    isFetching.value = false;

    if (response) {
      //Mensagem
      _utilsServices.showToast(message: 'A Senha foi atualizada com sucesso');

      // Logout
      signOut();
    } else {
      _utilsServices.showToast(
          message: 'Senha atual está incorreta', isError: true);
    }
  }
}
