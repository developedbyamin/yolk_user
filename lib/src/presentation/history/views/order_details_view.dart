import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yolla/core/config/constants/app_colors.dart';
import 'package:yolla/core/extensions/localization_extension.dart';
import 'package:yolla/src/data/models/product/product_model.dart';
import 'package:yolla/src/data/models/order/order_model.dart';
import 'package:yolla/src/presentation/history/viewmodel/order_cubit.dart';

class OrderDetailsView extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsView({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.blackColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Order #${order.id}',
          style: const TextStyle(
            color: AppColors.blackColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 32),
        child: Column(
          children: [
            // Combined Market Header and Products container
            Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              decoration: BoxDecoration(
                color: AppColors.lightGrayColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  // Market Header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                    child: Row(
                      children: [
                        // Market Logo
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.lightGrayColor, width: 2),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/bravo.jpg',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: AppColors.lightGrayColor,
                                  child: const Icon(
                                    Icons.store,
                                    color: AppColors.grayColor,
                                    size: 30,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        
                        const SizedBox(width: 16),
                        
                        // Market Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order.storeName,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.blackColor,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                order.storeAddress,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppColors.grayColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Products
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: order.products.length,
                    itemBuilder: (context, index) {
                      final product = order.products[index];
                      return OrderDetailsProductItem(product: product);
                    },
                  ),
                  
                  // Barcode section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          child: BarcodeWidget(
                            barcode: Barcode.code128(),
                            data: order.barcode ?? _generateBarcodeData(order),
                            width: 200,
                            height: 60,
                            drawText: false,
                            errorBuilder: (context, error) {
                              return Container(
                                height: 60,
                                width: 200,
                                child: const Center(
                                  child: Text(
                                    'Barcode Error',
                                    style: TextStyle(
                                      color: AppColors.grayColor,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Order Summary
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppColors.whiteColor,
              ),
              child: Column(
                children: [   
                  
                  // Total price
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.lightGrayColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          localizations.totalPrice,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.grayColor),
                        ),
                        Text(
                          '\$${order.totalPrice.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Delivery Details
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.lightGrayColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localizations.deliveryDetails,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.grayColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: AppColors.grayColor,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                order.storeAddress,
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Delivery Information
                  _buildDeliveryInfo(context, order),
                  
                  if (order.deliveryDate != null || order.deliveryTime != null || 
                      (order.deliveryStartDate != null && order.deliveryEndDate != null))
                    const SizedBox(height: 16),
                  
                  // Order Status
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: _getStatusColor(order.status).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _getStatusColor(order.status),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _getStatusText(order.status, localizations),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: _getStatusColor(order.status),
                        ),
                      ),
                    ),
                  ),

                  // Delete Button (only for pending orders)
                  if (order.status.toLowerCase() == 'pending') ...[
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ElevatedButton(
                        onPressed: () {
                          _showDeleteConfirmation(context, order, localizations);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.delete_outline,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              localizations.removeFromCart,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryInfo(BuildContext context, OrderModel order) {
    final localizations = context.localizations;
    
    // Check if we have new date range format
    if (order.deliveryStartDate != null && order.deliveryEndDate != null &&
        order.deliveryStartTime != null && order.deliveryEndTime != null) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.lightGrayColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                const Icon(
                  Icons.schedule,
                  color: AppColors.primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  localizations.deliveryTimeRange,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Date Range Display
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.primaryColor.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: AppColors.primaryColor,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${_formatDateTime(order.deliveryStartDate!, order.deliveryStartTime!)} - ${_formatDateTime(order.deliveryEndDate!, order.deliveryEndTime!)}',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    
    // Fall back to old format for backward compatibility
    if (order.deliveryDate != null || order.deliveryTime != null) {
      return Row(
        children: [
          // Order Date
          if (order.deliveryDate != null)
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.lightGrayColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Order Date',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.grayColor),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      order.deliveryDate!,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          
          if (order.deliveryDate != null && order.deliveryTime != null)
            const SizedBox(width: 12),
          
          // Order Time
          if (order.deliveryTime != null)
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.lightGrayColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Order Time',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.grayColor),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      order.deliveryTime!,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      );
    }
    
    return const SizedBox.shrink();
  }

  String _formatDateTime(DateTime date, String time) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year} $time';
  }

  String _generateBarcodeData(OrderModel order) {
    // Generate a unique barcode based on order data
    final totalPrice = order.totalPrice.toStringAsFixed(2);
    final productCount = order.products.length.toString();
    
    // Create a unique order ID format: YYYYMMDDHHMMSS + ProductCount + TotalPrice
    final orderDate = order.orderDate;
    final dateString = '${orderDate.year}${orderDate.month.toString().padLeft(2, '0')}${orderDate.day.toString().padLeft(2, '0')}';
    final timeString = '${orderDate.hour.toString().padLeft(2, '0')}${orderDate.minute.toString().padLeft(2, '0')}${orderDate.second.toString().padLeft(2, '0')}';
    
    return '$dateString$timeString$productCount${totalPrice.replaceAll('.', '')}';
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'delivered':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return AppColors.grayColor;
    }
  }

  String _getStatusText(String status, localizations) {
    switch (status.toLowerCase()) {
      case 'pending':
        return localizations.pending;
      case 'delivered':
        return localizations.delivered;
      case 'completed':
        return 'Completed';
      case 'cancelled':
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }

  void _showDeleteConfirmation(BuildContext context, OrderModel order, localizations) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(localizations.removeFromCart),
          content: Text(localizations.removeFromCartConfirmation),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(localizations.cancel),
            ),
            TextButton(
              onPressed: () async {
                // Delete the order
                await context.read<OrderCubit>().deleteOrder(order.id);
                
                // Close dialog
                Navigator.of(context).pop();
                
                // Go back to history view
                Navigator.of(context).pop();
                
                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(localizations.orderRemovedFromCart),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: Text(
                localizations.remove,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}

class OrderDetailsProductItem extends StatelessWidget {
  final ProductModel product;

  const OrderDetailsProductItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Product details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grayColor,
                      ),
                    ),
                    const Text(
                      ' × ',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.grayColor,
                      ),
                    ),
                    Text(
                      _formatQuantity(product.quantity, product.unit, localizations),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grayColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Total price for this product
          Text(
            '\$${(product.price * product.quantity).toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.grayColor,
            ),
          ),
        ],
      ),
    );
  }

  String _formatQuantity(double quantity, String unit, localizations) {
    String localizedUnit;
    if (unit == 'kg') {
      localizedUnit = localizations.kg;
      return '${quantity.toStringAsFixed(1)} $localizedUnit';
    } else {
      localizedUnit = localizations.pcs;
      return '${quantity.toInt()} $localizedUnit';
    }
  }
}