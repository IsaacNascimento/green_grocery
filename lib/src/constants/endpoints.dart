const String baseUrl = 'https://parseapi.back4app.com/functions';

abstract class EndPoint {
  // AUTH
  static const String signin = '$baseUrl/login';
  static const String validateToken = '$baseUrl/validate-token';
  static const String signup = '$baseUrl/signup';
  static const String resetPassword = '$baseUrl/reset-password';

  // HOME
  static const String categoryList = '$baseUrl/get-category-list';
  static const String productList = '$baseUrl/get-product-list';
}
