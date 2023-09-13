import 'package:get/get.dart';
import 'package:green_grocer/src/pages/auth/view/sign_in_screen.dart';
import 'package:green_grocer/src/pages/auth/view/sign_up_screen.dart';
import 'package:green_grocer/src/pages/base/base_screen.dart';
import 'package:green_grocer/src/pages/base/binding/navigation_binding.dart';
import 'package:green_grocer/src/pages/cart/bindings/cart_binding.dart';
import 'package:green_grocer/src/pages/home/binding/home_binding.dart';
import 'package:green_grocer/src/pages/orders/bindings/orders_binding.dart';
import 'package:green_grocer/src/pages/product/product_screen.dart';
import 'package:green_grocer/src/pages/splash/splash_screen.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    // Public Routes
    GetPage(
      name: PagesRoutes.splashRoute,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: PagesRoutes.signInRoute,
      page: () => const SignInScreen(),
    ),
    GetPage(
      name: PagesRoutes.signUpRoute,
      page: () => SignUpScreen(),
    ),

    // Private Routes
    GetPage(
      name: PagesRoutes.productRoute,
      page: () => ProductScreen(),
    ),
    GetPage(
      name: PagesRoutes.baseRoute,
      page: () => const BaseScreen(),
      bindings: [
        NavigationBinding(),
        HomeBinding(),
        CartBinding(),
        OrdersBindings(),
      ],
    ),
  ];
}

abstract class PagesRoutes {
  // Auth
  static const String splashRoute = '/splash';
  static const String signInRoute = '/signin';
  static const String signUpRoute = '/signup';

  // Private Routes
  static const String baseRoute = '/';
  static const String productRoute = '/product';
}
