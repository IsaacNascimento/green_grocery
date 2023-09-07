import 'package:green_grocer/src/constants/endpoints.dart';
import 'package:green_grocer/src/services/http_manager.dart';

class CartRepository {
  final HttpManager _httpManager = HttpManager();

  // <CartResult<List>>
  Future getCartItems({
    required String token,
    required String userId,
  }) async {
    // print("(repository) => user id: $userId, user token: $token");
    final result = await _httpManager.restRequest(
        url: EndPoint.getCartItems,
        method: HttpMethods.post,
        headers: {
          'X-Parse-Session-Token': token
        },
        body: {
          'user': userId,
        });

    if (result['status'] == 200) {
      final List items = result['result'];
      print('items: $items');
    } else {
      print(result);
    }
  }
}
