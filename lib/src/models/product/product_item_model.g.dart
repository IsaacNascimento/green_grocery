// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductItemModel _$ProductItemModelFromJson(Map<String, dynamic> json) =>
    ProductItemModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      unit: json['unit'] as String? ?? '',
      picture: json['picture'] as String? ?? '',
      category: json['category'] == null
          ? null
          : CategoryItemModel.fromJson(
              json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductItemModelToJson(ProductItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'unit': instance.unit,
      'picture': instance.picture,
      'category': instance.category,
    };
