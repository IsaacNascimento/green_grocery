// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

// to generate MapToJsom: Run => dart run build_runner build

@JsonSerializable()
class UserModel {
  String email;

  @JsonKey(name: 'fullname')
  String? name;

  String? password;
  String? phone;
  String? cpf;
  String? id;
  String? token;

  UserModel({
    required this.email,
    this.password,
    this.name,
    this.phone,
    this.cpf,
    this.id,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  String toString() {
    return 'UserModel(email: $email, name: $name, password: $password, phone: $phone, cpf: $cpf, id: $id, token: $token)';
  }
}
