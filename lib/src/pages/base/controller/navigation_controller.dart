import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class NavigationTabas {
  static const int home = 0;
  static const int cart = 1;
  static const int orders = 2;
  static const int profile = 3;
}

class NavigationController extends GetxController {
  late PageController _pageController;
  late RxInt _currentIndex;

  @override
  void onInit() {
    super.onInit();
    initNavigation(
      pageController: PageController(initialPage: NavigationTabas.home),
      currentIndex: NavigationTabas.home,
    );
  }

  void initNavigation({
    required PageController pageController,
    required int currentIndex,
  }) {
    _pageController = pageController;
    _currentIndex = currentIndex.obs;
  }

  void navigatePageView(int page) {
    if (_currentIndex.value != page) {
      _pageController.jumpToPage(page);
      _currentIndex.value = page;
    }
  }
}
