// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:green_grocer/src/models/cart/cart_item_model.dart';

part 'order_item_model.g.dart';

@JsonSerializable()
class OrderModel {
  String id;

  @JsonKey(name: 'createdAt')
  DateTime? createdDateTime;

  @JsonKey(defaultValue: [])
  List<CartItemModel> items;
  String status;
  double total;

  String qrCodeImage;

  @JsonKey(name: 'due')
  DateTime overdueDateTime;

  @JsonKey(name: 'copiaecola')
  String copyAndPaste;

  OrderModel({
    required this.id,
    this.createdDateTime,
    required this.items,
    required this.status,
    required this.total,
    required this.qrCodeImage,
    required this.overdueDateTime,
    required this.copyAndPaste,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  @override
  String toString() {
    return 'OrderModel(id: $id, createdDateTime: $createdDateTime, overdueDateTime: $overdueDateTime, items: $items, status: $status, copyAndPaste: $copyAndPaste, total: $total)';
  }
}
