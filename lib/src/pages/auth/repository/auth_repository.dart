import 'package:green_grocer/src/constants/endpoints.dart';
import 'package:green_grocer/src/models/user_model.dart';
import 'package:green_grocer/src/pages/auth/result/auth_result.dart';
import 'package:green_grocer/src/services/http_manager.dart';
import 'package:green_grocer/src/pages/auth/repository/auth_errors.dart'
    as auth_errors;

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  handleUserOrError(Map<dynamic, dynamic> result) {
    if (result['result'] != null) {
      final user = UserModel.fromJson(result['result']);
      return AuthResult.success(user);
    } else {
      String? errorMessage = auth_errors.authErrorsString(result['error']);
      return AuthResult.error(errorMessage);
    }
  }

  Future<AuthResult> validateToken(String token) async {
    final result = await _httpManager.restRequest(
        url: EndPoint.validateToken,
        method: HttpMethods.post,
        headers: {
          'X-Parse-Session-Token': token,
        });

    return handleUserOrError(result);
  }

  Future<AuthResult> signIn(
      {required String email, required String password}) async {
    final result = await _httpManager.restRequest(
      url: EndPoint.signin,
      method: HttpMethods.post,
      body: {
        'email': email,
        'password': password,
      },
    );

    return handleUserOrError(result);
  }

  Future<AuthResult> signUp(UserModel user) async {
    // print('repository: $user');
    final result = await _httpManager.restRequest(
      url: EndPoint.signup,
      method: HttpMethods.post,
      body: user.toJson(),
    );

    //   print('result: $result');
    return handleUserOrError(result);
  }
}
