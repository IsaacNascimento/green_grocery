const String baseUrl = 'https://parseapi.back4app.com/functions';

abstract class EndPoint {
  static const String signin = '$baseUrl/login';
  static const String signup = '$baseUrl/signup';
}
