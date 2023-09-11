import 'package:green_grocer/src/constants/endpoints.dart';
import 'package:green_grocer/src/models/cart/cart_item_model.dart';
import 'package:green_grocer/src/pages/cart/result/cart_result.dart';
import 'package:green_grocer/src/services/http_manager.dart';

class CartRepository {
  final HttpManager _httpManager = HttpManager();

  // Método asyncrono; Que retorna um CartResult, com uma Lista de CartItemModel
  Future<CartResult<List<CartItemModel>>> getCartItems({
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
      final List<CartItemModel> items = [];
      for (var item in result['result']) {
        items.add(CartItemModel.fromJson(item));
      }
      // print('items: $items');
      return CartResult<List<CartItemModel>>.success(items);
    } else {
      String errorMessage = 'Ocorreu um erro ao recuperar os itens do carrinho';
      return CartResult.error(errorMessage);
    }
  }

  Future<CartResult<String>> addItemToCart({
    required String token,
    required String userId,
    required int quantity,
    required String productId,
  }) async {
    final result = await _httpManager.restRequest(
      url: EndPoint.addItemToCart,
      method: HttpMethods.post,
      headers: {'X-Parse-Session-Token': token},
      body: {
        'user': userId,
        'quantity': quantity,
        'productId': productId,
      },
    );

    if (result['status'] == 200) {
      // print(result);
      return CartResult<String>.success(result['result']['id']);
    } else {
      // print(result['error']);
      String errorMessage = 'Não foi possível adicionar o item ao carrinho';
      return CartResult.error(errorMessage);
    }
  }

  Future<bool> modifyItemQuantity({
    required String token,
    required int quantity,
    required String cartItemId,
  }) async {
    final result = await _httpManager.restRequest(
      url: EndPoint.modifyItemQuantity,
      method: HttpMethods.post,
      headers: {
        'X-Parse-Session-Token': token,
      },
      body: {
        'quantity': quantity,
        'cartItemId': cartItemId,
      },
    );

    if (result['status'] == 200) {
      // print('(repository) result: ${result['result']}');
      return true;
    } else {
      // print('(repository) error: ${result['erro']}');
      return false;
    }
  }
}
