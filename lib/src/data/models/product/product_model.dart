import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
abstract class ProductModel with _$ProductModel {
  const factory ProductModel({
    required String id,
    required String name,
    required String barcode,
    required double price,
    required String description,
    @Default(0.0) double quantity,
    String? imageUrl,
    @Default('pcs') String unit, // 'kg', 'pcs', 'l' etc.
    @Default(1.0) double step, // increment/decrement step (0.1 for kg, 1.0 for pcs)
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}