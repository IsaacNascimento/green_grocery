// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'category_item_model.g.dart';

@JsonSerializable()
class CategoryItemModel {
  String? title;
  String? id;

  CategoryItemModel({
    this.title,
    this.id,
  });

  factory CategoryItemModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryItemModelToJson(this);

  @override
  String toString() {
    return 'CategoryItemModel(title: $title, id: $id)';
  }
}
