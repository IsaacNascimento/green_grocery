const String baseUrl = 'https://parseapi.back4app.com/functions';

abstract class EndPoint {
  // AUTH
  static const String signin = '$baseUrl/login';
  static const String validateToken = '$baseUrl/validate-token';
  static const String signup = '$baseUrl/signup';
  static const String resetPassword = '$baseUrl/reset-password';

  static const String changePassword = '$baseUrl/change-password';

  // HOME
  static const String categoryList = '$baseUrl/get-category-list';
  static const String productList = '$baseUrl/get-product-list';

  // CART
  static const String cartItemsList = '$baseUrl/get-cart-items';
  static const String addItemToCart = '$baseUrl/add-item-to-cart';
  static const String modifyItemQuantity = '$baseUrl/modify-item-quantity';

  // ORDER
  static const String checkoutOrder = '$baseUrl/checkout';
  static const String ordersList = '$baseUrl/get-orders';
  static const String itemsOrdersList = '$baseUrl/get-order-items';
}
