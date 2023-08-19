// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:green_grocer/src/models/category/category_item_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_item_model.g.dart';

@JsonSerializable()
class ProductItemModel {
  String id;
  String title;
  String description;
  double price;
  String unit;
  String picture;
  CategoryItemModel? category;

  ProductItemModel({
    this.id = '',
    this.title = '',
    this.description = '',
    this.price = 0,
    this.unit = '',
    this.picture = '',
    this.category,
  });

  factory ProductItemModel.fromJson(Map<String, dynamic> json) =>
      _$ProductItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductItemModelToJson(this);

  @override
  String toString() {
    return 'ProductItemModel(id: $id, title: $title, description: $description, price: $price, unit: $unit, picture: $picture, category: $category)';
  }
}
