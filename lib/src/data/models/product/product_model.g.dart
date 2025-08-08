// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductModel _$ProductModelFromJson(Map<String, dynamic> json) =>
    _ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      barcode: json['barcode'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      quantity: (json['quantity'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['imageUrl'] as String?,
      unit: json['unit'] as String? ?? 'pcs',
      step: (json['step'] as num?)?.toDouble() ?? 1.0,
    );

Map<String, dynamic> _$ProductModelToJson(_ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'barcode': instance.barcode,
      'price': instance.price,
      'description': instance.description,
      'quantity': instance.quantity,
      'imageUrl': instance.imageUrl,
      'unit': instance.unit,
      'step': instance.step,
    };
