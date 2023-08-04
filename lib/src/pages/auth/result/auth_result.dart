import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:green_grocer/src/models/user_model.dart';

part 'auth_result.freezed.dart';

// # Para gerar arquivo 'auth_result.freezed.dart' run => dart run build_runner build

@freezed
class AuthResult with _$AuthResult {
  factory AuthResult.success(UserModel user) = Success;
  factory AuthResult.error(String error) = Error;
}
