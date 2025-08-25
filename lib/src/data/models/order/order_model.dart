import 'package:yolla/src/data/models/product/product_model.dart';

class OrderModel {
  final String id;
  final List<ProductModel> products;
  final double totalPrice;
  final DateTime orderDate;
  final String status; // 'completed', 'pending', 'cancelled'
  final String storeName;
  final String storeAddress;
  final String? deliveryDate;
  final String? deliveryTime;
  final DateTime? deliveryStartDate;
  final DateTime? deliveryEndDate;
  final String? deliveryStartTime;
  final String? deliveryEndTime;
  final String? barcode;

  const OrderModel({
    required this.id,
    required this.products,
    required this.totalPrice,
    required this.orderDate,
    required this.status,
    required this.storeName,
    required this.storeAddress,
    this.deliveryDate,
    this.deliveryTime,
    this.deliveryStartDate,
    this.deliveryEndDate,
    this.deliveryStartTime,
    this.deliveryEndTime,
    this.barcode,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String,
      products: (json['products'] as List)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
      orderDate: DateTime.parse(json['orderDate'] as String),
      status: json['status'] as String,
      storeName: json['storeName'] as String,
      storeAddress: json['storeAddress'] as String,
      deliveryDate: json['deliveryDate'] as String?,
      deliveryTime: json['deliveryTime'] as String?,
      deliveryStartDate: json['deliveryStartDate'] != null 
          ? DateTime.parse(json['deliveryStartDate'] as String)
          : null,
      deliveryEndDate: json['deliveryEndDate'] != null 
          ? DateTime.parse(json['deliveryEndDate'] as String)
          : null,
      deliveryStartTime: json['deliveryStartTime'] as String?,
      deliveryEndTime: json['deliveryEndTime'] as String?,
      barcode: json['barcode'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'products': products.map((e) => e.toJson()).toList(),
      'totalPrice': totalPrice,
      'orderDate': orderDate.toIso8601String(),
      'status': status,
      'storeName': storeName,
      'storeAddress': storeAddress,
      'deliveryDate': deliveryDate,
      'deliveryTime': deliveryTime,
      'deliveryStartDate': deliveryStartDate?.toIso8601String(),
      'deliveryEndDate': deliveryEndDate?.toIso8601String(),
      'deliveryStartTime': deliveryStartTime,
      'deliveryEndTime': deliveryEndTime,
      'barcode': barcode,
    };
  }
}