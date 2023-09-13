import 'package:get/get.dart';
import 'package:green_grocer/src/constants/storage_keys.dart';
import 'package:green_grocer/src/models/order/order_item_model.dart';
import 'package:green_grocer/src/pages/orders/repository/orders_repository.dart';
import 'package:green_grocer/src/pages/orders/result/orders_result.dart';
import 'package:green_grocer/src/services/token_servicer.dart';
import 'package:green_grocer/src/services/utils_services.dart';

class OrderController extends GetxController {
  // Global Variables
  List<OrderModel> orders = [];
  bool isFetching = false;

  // Private Variables
  String? _userId;

  // Private Instances
  final _orderRepository = OrdersRepository();
  final _tokenService = TokenService();
  final _utilsService = UtilsServices();

  // Methods
  void _setIsLoading({required bool isLoading}) {
    isFetching = isLoading;
    update();
  }

  Future<void> _getUserId() async {
    _userId = await _tokenService.readData(key: StorageKeys.userId);
  }

  Future<void> getOrdesLists() async {
    _setIsLoading(isLoading: true);

    _getUserId();
    final OrderResult<List<OrderModel>> result =
        await _orderRepository.getOrdesLists(
      userId: _userId!,
    );

    _setIsLoading(isLoading: false);

    result.when(
      success: (data) {
        orders = data;
        update();
      },
      error: (error) {
        _utilsService.showToast(message: error, isError: true);
      },
    );
  }
}
