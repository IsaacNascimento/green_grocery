// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      email: json['email'] as String,
      password: json['password'] as String?,
      name: json['fullname'] as String?,
      phone: json['phone'] as String?,
      cpf: json['cpf'] as String?,
      id: json['id'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'email': instance.email,
      'fullname': instance.name,
      'password': instance.password,
      'phone': instance.phone,
      'cpf': instance.cpf,
      'id': instance.id,
      'token': instance.token,
    };
