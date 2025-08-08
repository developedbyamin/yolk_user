import 'package:yolla/src/data/models/order/order_model.dart';

class OrderState {
  final List<OrderModel> orders;
  final bool isLoading;
  final String? error;

  const OrderState({
    required this.orders,
    required this.isLoading,
    this.error,
  });

  factory OrderState.initial() {
    return const OrderState(
      orders: [],
      isLoading: false,
    );
  }

  OrderState copyWith({
    List<OrderModel>? orders,
    bool? isLoading,
    String? error,
  }) {
    return OrderState(
      orders: orders ?? this.orders,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  List<OrderModel> get pendingOrders => orders.where((order) => order.status == 'pending').toList();
  List<OrderModel> get deliveredOrders => orders.where((order) => order.status == 'delivered').toList();
}