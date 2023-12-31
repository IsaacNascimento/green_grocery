import 'package:green_grocer/src/constants/endpoints.dart';
import 'package:green_grocer/src/models/cart/cart_item_model.dart';
import 'package:green_grocer/src/models/order/order_item_model.dart';
import 'package:green_grocer/src/pages/orders/result/orders_result.dart';
import 'package:green_grocer/src/services/http_manager.dart';

class OrdersRepository {
  final _httpManager = HttpManager();

  Future<OrderResult<List<OrderModel>>> getOrdesLists(
      {required String userId}) async {
    final result = await _httpManager.restRequest(
      url: EndPoint.ordersList,
      method: HttpMethods.post,
      body: {
        'user': userId,
      },
    );

    if (result['status'] == 200) {
      final List<OrderModel> items = [];
      for (var order in result['result']) {
        items.add(OrderModel.fromJson(order));
      }

      // print('(order repository) - success: $items');
      return OrderResult<List<OrderModel>>.success(items);
    } else {
      // print('(order repository) - success: ${result['error']}');
      const String errorMessage = 'Não foi possível recuperar os Pedidos';
      return OrderResult.error(errorMessage);
    }
  }

  Future<OrderResult<List<CartItemModel>>> getItemsOrdersList(
      {required String orderId}) async {
    final result = await _httpManager.restRequest(
        url: EndPoint.itemsOrdersList,
        method: HttpMethods.post,
        body: {
          'orderId': orderId,
        });

    if (result['status'] == 200) {
      final List<CartItemModel> items = [];
      for (var cart in result['result']) {
        items.add(CartItemModel.fromJson(cart));
      }
      return OrderResult<List<CartItemModel>>.success(items);
    } else {
      String errorMessage = 'Não foi possível recuperar os produtos do pedido';
      return OrderResult.error(errorMessage);
    }
  }
}
