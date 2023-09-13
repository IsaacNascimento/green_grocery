import 'package:dio/dio.dart';
import 'package:green_grocer/src/constants/storage_keys.dart';
import 'package:green_grocer/src/services/token_servicer.dart';

abstract class HttpMethods {
  static const String post = 'POST';
  static const String get = 'GET';
  static const String put = 'PUT';
  static const String putch = 'PUTCH';
  static const String delete = 'DELETE';
}

class HttpManager {
  Future<Map> restRequest({
    required String url,
    required String method,
    Map? headers,
    Map? body,
  }) async {
    final tokenService = TokenService();
    final token =
        await tokenService.readData(key: StorageKeys.tokenGreenGrocer);
    // Headers
    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll({
        'content-type': 'application/json',
        'accept': 'application/json',
        'X-Parse-Application-Id': 'wK7GcEjr2V4br5q5mlR1kybQ5dvxMFDX0qtE1d6Y',
        'X-Parse-REST-API-Key': '2kahi62fkWePLWAwC7k8aMrtQkobogcgkruMxbeB',
        'X-Parse-Session-Token': token ?? '',
      });

    Dio dio = Dio();

    try {
      Response response = await dio.request(
        url,
        options: Options(method: method, headers: defaultHeaders),
        data: body,
      );

      Map<String, dynamic> data = {
        'status': response.statusCode,
        'result': response.data['result'],
      };
      // Retorno backend
      return data;
    } on DioException catch (e) {
      // Retorno do error do dio request;
      return e.response?.data ?? {};
    } catch (e) {
      // Retorno de error genérico
      return {};
    }
  }
}
