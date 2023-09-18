import 'package:get/get.dart';
import 'package:green_grocer/src/models/cart/cart_item_model.dart';
import 'package:green_grocer/src/models/order/order_item_model.dart';
import 'package:green_grocer/src/pages/orders/repository/orders_repository.dart';
import 'package:green_grocer/src/pages/orders/result/orders_result.dart';
import 'package:green_grocer/src/services/utils_services.dart';

class ItemsOrderController extends GetxController {
  // Global Variables
  OrderModel order;
  bool isFetching = false;

  ItemsOrderController(this.order);

  // Private Instances
  final _orderRepository = OrdersRepository();
  final _utilsService = UtilsServices();

  void _setIsLoading({required bool isLoading}) {
    isFetching = isLoading;
    update();
  }

  Future<void> getItemsOrdersList() async {
    _setIsLoading(isLoading: true);

    final OrderResult<List<CartItemModel>> result =
        await _orderRepository.getItemsOrdersList(
      orderId: order.id,
    );

    _setIsLoading(isLoading: false);

    result.when(
      success: (data) {
        order.items = data;
        update();
      },
      error: (error) {
        _utilsService.showToast(message: error, isError: true);
      },
    );
  }
}
