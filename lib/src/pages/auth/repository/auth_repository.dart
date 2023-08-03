import 'package:green_grocer/src/constants/endpoints.dart';
import 'package:green_grocer/src/models/user_model.dart';
import 'package:green_grocer/src/services/http_manager.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  Future signIn({required String email, required String password}) async {
    final result = await _httpManager.restRequest(
      url: EndPoint.signin,
      method: HttpMethods.post,
      body: {
        "email": email,
        "password": password,
      },
    );

    if (result['result'] != null) {
      final user = UserModel.fromMap(result['result']);
      print(user);
      return user;
    } else {
      Map<String, dynamic> error = {
        "message": "Ocorreu algum error",
        "error": result,
      };
      print(error);
      return error;
    }
  }
}
