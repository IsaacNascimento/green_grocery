import 'package:get/get.dart';
import 'package:green_grocer/src/models/user_model.dart';
import 'package:green_grocer/src/pages/auth/repository/auth_repository.dart';

class AuthController extends GetxController {
  RxBool isFetching = false.obs;

  final authRepository = AuthRepository();

  Future<void> signIn(UserModel user) async {
    isFetching.value = true;

    await authRepository.signIn(email: user.email, password: user.password);

    isFetching.value = false;
  }
}
