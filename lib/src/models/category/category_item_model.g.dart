// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryItemModel _$CategoryItemModelFromJson(Map<String, dynamic> json) =>
    CategoryItemModel(
      title: json['title'] as String?,
      id: json['id'] as String?,
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => ProductItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$CategoryItemModelToJson(CategoryItemModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'id': instance.id,
      'items': instance.items,
    };
