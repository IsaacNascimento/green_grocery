import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  // Salva dado localmente em segurança
  Future<void> saveData({required String key, required String data}) async {
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();

    localStorage.setString(key, data);
  }

  // Recupera dado salvo localmente em segurança
  Future<String?> readData({required String key}) async {
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();

    final String? token = localStorage.getString(key);

    return token;
  }

  // Remove dado salvo localmente
  Future<void> removeData({required String key}) async {
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();

    localStorage.remove(key);
  }
}
