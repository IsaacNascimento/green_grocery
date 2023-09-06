// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchProductModel _$SearchProductModelFromJson(Map<String, dynamic> json) =>
    SearchProductModel(
      page: json['page'] as int? ?? 0,
      itemsPerPage: json['itemsPerPage'] as int? ?? 6,
      title: json['title'] as String?,
      categoryId: json['categoryId'] as String?,
    );

Map<String, dynamic> _$SearchProductModelToJson(SearchProductModel instance) =>
    <String, dynamic>{
      'page': instance.page,
      'itemsPerPage': instance.itemsPerPage,
      'title': instance.title,
      'categoryId': instance.categoryId,
    };
