// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: json['id'] as String,
      createdDateTime: json['createdDateTime'] == null
          ? null
          : DateTime.parse(json['createdDateTime'] as String),
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      status: json['status'] as String,
      total: (json['total'] as num).toDouble(),
      qrCodeImage: json['qrCodeImage'] as String,
      overdueDateTime: DateTime.parse(json['due'] as String),
      copyAndPaste: json['copiaecola'] as String,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdDateTime': instance.createdDateTime?.toIso8601String(),
      'items': instance.items,
      'status': instance.status,
      'total': instance.total,
      'qrCodeImage': instance.qrCodeImage,
      'due': instance.overdueDateTime.toIso8601String(),
      'copiaecola': instance.copyAndPaste,
    };
