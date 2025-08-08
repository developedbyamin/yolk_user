import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yolla/src/data/models/order/order_model.dart';
import 'package:yolla/src/data/models/product/product_model.dart';
import 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  static const String _ordersKey = 'saved_orders';

  OrderCubit() : super(OrderState.initial()) {
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    try {
      emit(state.copyWith(isLoading: true));
      
      final prefs = await SharedPreferences.getInstance();
      final ordersJson = prefs.getString(_ordersKey);
      
      List<OrderModel> orders = [];
      
      if (ordersJson != null) {
        final List<dynamic> ordersList = json.decode(ordersJson);
        orders = ordersList.map((json) {
          final orderData = json as Map<String, dynamic>;
          // Migrate old "Bazar Store" orders to "Bravo"
          if (orderData['storeName'] == 'Bazar Store') {
            orderData['storeName'] = 'Bravo';
            orderData['storeAddress'] = 'Nizami küçəsi 28, Bakı';
          }
          return OrderModel.fromJson(orderData);
        }).toList();
        // Save the migrated orders
        await _saveOrders(orders);
      } else {
        // Add some default mock orders if no orders exist
        orders = _getDefaultOrders();
        await _saveOrders(orders);
      }
      
      emit(state.copyWith(
        orders: orders,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to load orders: $e',
        isLoading: false,
      ));
    }
  }

  Future<void> addOrder(OrderModel order) async {
    try {
      final updatedOrders = [order, ...state.orders];
      await _saveOrders(updatedOrders);
      
      emit(state.copyWith(orders: updatedOrders));
    } catch (e) {
      emit(state.copyWith(error: 'Failed to add order: $e'));
    }
  }

  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    try {
      final updatedOrders = state.orders.map((order) {
        if (order.id == orderId) {
          return OrderModel(
            id: order.id,
            products: order.products,
            totalPrice: order.totalPrice,
            orderDate: order.orderDate,
            status: newStatus,
            storeName: order.storeName,
            storeAddress: order.storeAddress,
            deliveryDate: order.deliveryDate,
            deliveryTime: order.deliveryTime,
            barcode: order.barcode,
          );
        }
        return order;
      }).toList();
      
      await _saveOrders(updatedOrders);
      emit(state.copyWith(orders: updatedOrders));
    } catch (e) {
      emit(state.copyWith(error: 'Failed to update order: $e'));
    }
  }

  Future<void> _saveOrders(List<OrderModel> orders) async {
    final prefs = await SharedPreferences.getInstance();
    final ordersJson = json.encode(orders.map((order) => order.toJson()).toList());
    await prefs.setString(_ordersKey, ordersJson);
  }

  List<OrderModel> _getDefaultOrders() {
    return [
      // Delivered orders (older orders)
      OrderModel(
        id: '20241115001',
        products: [
          const ProductModel(
            id: '3',
            name: 'Chicken Breast',
            barcode: '1111222233',
            price: 8.99,
            description: 'Fresh chicken breast',
            quantity: 0.8,
            unit: 'kg',
          ),
          const ProductModel(
            id: '4',
            name: 'Rice',
            barcode: '4444555566',
            price: 3.45,
            description: 'Basmati rice',
            quantity: 1.0,
            unit: 'kg',
          ),
        ],
        totalPrice: 10.64,
        orderDate: DateTime.now().subtract(const Duration(days: 1)),
        status: 'delivered',
        storeName: 'Bravo',
        storeAddress: 'Nizami küçəsi 28, Bakı',
        deliveryDate: '15/11/2024',
        deliveryTime: '16:00',
        barcode: '202411150021064',
      ),
      OrderModel(
        id: '20241114002',
        products: [
          const ProductModel(
            id: '5',
            name: 'Milk',
            barcode: '7777888899',
            price: 1.89,
            description: 'Fresh milk 1L',
            quantity: 3.0,
            unit: 'pcs',
          ),
          const ProductModel(
            id: '6',
            name: 'Apples',
            barcode: '9999888877',
            price: 4.20,
            description: 'Fresh red apples',
            quantity: 2.0,
            unit: 'kg',
          ),
        ],
        totalPrice: 13.47,
        orderDate: DateTime.now().subtract(const Duration(days: 2)),
        status: 'delivered',
        storeName: 'Bravo',
        storeAddress: 'Nizami küçəsi 28, Bakı',
        deliveryDate: '14/11/2024',
        deliveryTime: '10:30',
        barcode: '202411140031347',
      ),
      OrderModel(
        id: '20241113003',
        products: [
          const ProductModel(
            id: '7',
            name: 'Pasta',
            barcode: '5555666677',
            price: 2.30,
            description: 'Italian pasta',
            quantity: 2.0,
            unit: 'pcs',
          ),
        ],
        totalPrice: 4.60,
        orderDate: DateTime.now().subtract(const Duration(days: 3)),
        status: 'delivered',
        storeName: 'Bravo',
        storeAddress: 'Nizami küçəsi 28, Bakı',
        deliveryDate: '13/11/2024',
        deliveryTime: '12:00',
        barcode: '202411130020460',
      ),
    ];
  }

  Future<void> loadOrders() async {
    await _loadOrders();
  }

  List<OrderModel> get pendingOrders => state.orders.where((order) => order.status == 'pending').toList();
  List<OrderModel> get deliveredOrders => state.orders.where((order) => order.status == 'delivered').toList();
}