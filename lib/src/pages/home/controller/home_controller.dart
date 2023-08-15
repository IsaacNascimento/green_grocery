import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool isFetching = false.obs;

  void printExample() {
    print('Home Controller');
  }
}
