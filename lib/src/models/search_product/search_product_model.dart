// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'search_product_model.g.dart';

@JsonSerializable()
class SearchProductModel {
  int? page;
  int itemsPerPage;
  String? title;
  String? categoryId;

  SearchProductModel({
    this.page = 0,
    this.itemsPerPage = 6,
    this.title,
    this.categoryId,
  });

  factory SearchProductModel.fromJson(Map<String, dynamic> json) =>
      _$SearchProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchProductModelToJson(this);

  @override
  String toString() {
    return 'SearchProductModel(page: $page, itemsPerPage: $itemsPerPage, title: $title, categoryId: $categoryId)';
  }
}
