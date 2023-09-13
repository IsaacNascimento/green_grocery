import 'package:get/get.dart';
import 'package:green_grocer/src/pages/orders/controller/order_controller.dart';

class OrdersBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(OrderController());
  }
}
