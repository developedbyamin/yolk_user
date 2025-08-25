import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:yolla/core/config/constants/app_colors.dart';
import 'package:yolla/core/extensions/localization_extension.dart';
import 'package:yolla/src/data/models/product/product_model.dart';
import 'package:yolla/src/data/models/order/order_model.dart';
import 'package:yolla/src/presentation/qr/viewmodel/qr_cubit.dart';
import 'package:yolla/src/presentation/history/viewmodel/order_cubit.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  DateTime? _startDate;
  DateTime? _endDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    
    // Get the selected products passed from the previous screen
    final List<ProductModel> selectedProducts = 
        ModalRoute.of(context)?.settings.arguments as List<ProductModel>? ?? [];

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
          localizations.checkout,
          style: const TextStyle(
            color: AppColors.blackColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: selectedProducts.isEmpty
          ? Center(
              child: Text(
                localizations.noProductsSelected,
                style: const TextStyle(
                  fontSize: 18,
                  color: AppColors.grayColor,
                ),
              ),
            )
          : SingleChildScrollView(
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
                                                        const Text(
                      'Bravo',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackColor,
                      ),
                    ),
                                                        const SizedBox(height: 4),
                    const Text(
                      'Nizami küçəsi 28, Bakı',
                      style: TextStyle(
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
                          itemCount: selectedProducts.length,
                          itemBuilder: (context, index) {
                            final product = selectedProducts[index];
                            return CheckoutProductItem(product: product);
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
                                  data: _generateBarcodeData(selectedProducts),
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
                              '\$${_calculateTotalPrice(selectedProducts).toStringAsFixed(2)}',
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
                                    'Nizami küçəsi 28, Bakı, Azerbaijan',
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
                      
                      // Delivery Date Range Section
                      DeliveryDateRangeWidget(
                        startDate: _startDate,
                        endDate: _endDate,
                        startTime: _startTime,
                        endTime: _endTime,
                        onDateRangeChanged: (startDate, endDate, startTime, endTime) {
                          setState(() {
                            _startDate = startDate;
                            _endDate = endDate;
                            _startTime = startTime;
                            _endTime = endTime;
                          });
                        },
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Place Order Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Create order from selected products
                            final order = OrderModel(
                              id: DateTime.now().millisecondsSinceEpoch.toString(),
                              products: selectedProducts,
                              totalPrice: _calculateTotalPrice(selectedProducts),
                              orderDate: DateTime.now(),
                              status: 'pending', // Orders start as pending
                              storeName: 'Bravo',
                              storeAddress: 'Nizami küçəsi 28, Bakı',
                                                            deliveryDate: null,
                              deliveryTime: null,
                              deliveryStartDate: _startDate,
                              deliveryEndDate: _endDate,
                              deliveryStartTime: _startTime != null 
                                  ? '${_startTime!.hour.toString().padLeft(2, '0')}:${_startTime!.minute.toString().padLeft(2, '0')}'
                                  : null,
                              deliveryEndTime: _endTime != null 
                                  ? '${_endTime!.hour.toString().padLeft(2, '0')}:${_endTime!.minute.toString().padLeft(2, '0')}'
                                  : null,
                              barcode: _generateBarcodeData(selectedProducts),
                            );
                            
                            // Add order to history
                            context.read<OrderCubit>().addOrder(order);
                            
                            // Reset the QR cubit to clear all scanned products
                            context.read<QrCubit>().resetScanning();
                            
                            // Navigate back to QR view and show success message
                            context.pop();
                            
                            // Show success message after a short delay to ensure navigation completes
                            Future.delayed(const Duration(milliseconds: 100), () {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(localizations.orderPlacedSuccessfully),
                                    backgroundColor: Colors.green,
                                    duration: const Duration(seconds: 3),
                                  ),
                                );
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            localizations.pay,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }

  double _calculateTotalPrice(List<ProductModel> products) {
    return products.fold(0.0, (total, product) {
      return total + (product.price * product.quantity);
    });
  }



  String _generateBarcodeData(List<ProductModel> products) {
    // Generate a unique barcode based on order data
    final totalPrice = _calculateTotalPrice(products).toStringAsFixed(2);
    final productCount = products.length.toString();
    
    // Create a unique order ID format: YYYYMMDDHHMMSS + ProductCount + TotalPrice
    final orderDate = DateTime.now();
    final dateString = '${orderDate.year}${orderDate.month.toString().padLeft(2, '0')}${orderDate.day.toString().padLeft(2, '0')}';
    final timeString = '${orderDate.hour.toString().padLeft(2, '0')}${orderDate.minute.toString().padLeft(2, '0')}${orderDate.second.toString().padLeft(2, '0')}';
    
    return '$dateString$timeString$productCount${totalPrice.replaceAll('.', '')}';
  }


}

class CheckoutProductItem extends StatelessWidget {
  final ProductModel product;

  const CheckoutProductItem({
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

class DeliveryDateRangeWidget extends StatelessWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final Function(DateTime?, DateTime?, TimeOfDay?, TimeOfDay?) onDateRangeChanged;

  const DeliveryDateRangeWidget({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.onDateRangeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
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
          
          // Description
          Text(
            localizations.youCanDeliverBetween,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: AppColors.grayColor,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Date Range Selection
          Row(
            children: [
              // Start Date & Time
              Expanded(
                child: _buildDateTimeSelector(
                  context,
                  isStart: true,
                  date: startDate,
                  time: startTime,
                  dateLabel: localizations.fromDate,
                  onTap: () => _selectStartDateTime(context),
                ),
              ),
              
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  Icons.arrow_forward,
                  color: AppColors.grayColor,
                  size: 20,
                ),
              ),
              
              // End Date & Time
              Expanded(
                child: _buildDateTimeSelector(
                  context,
                  isStart: false,
                  date: endDate,
                  time: endTime,
                  dateLabel: localizations.toDate,
                  onTap: () => _selectEndDateTime(context),
                ),
              ),
            ],
          ),
          
          // Selected Range Display
          if (startDate != null && endDate != null && startTime != null && endTime != null) ...[
            const SizedBox(height: 16),
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
                      '${_formatDateTime(startDate!, startTime!)} - ${_formatDateTime(endDate!, endTime!)}',
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
        ],
      ),
    );
  }

  Widget _buildDateTimeSelector(
    BuildContext context, {
    required bool isStart,
    required DateTime? date,
    required TimeOfDay? time,
    required String dateLabel,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: date != null && time != null 
                ? AppColors.primaryColor.withOpacity(0.3)
                : AppColors.grayColor.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              dateLabel,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.grayColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            if (date != null && time != null) ...[
              Text(
                '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ] else ...[
              const Icon(
                Icons.add_circle_outline,
                color: AppColors.grayColor,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                'Tap to select',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.grayColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime date, TimeOfDay time) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year} ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _selectStartDateTime(BuildContext context) async {
    final localizations = context.localizations;
    
    // First select date
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      helpText: localizations.selectStartDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: AppColors.whiteColor,
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryColor,
              onPrimary: AppColors.whiteColor,
              surface: AppColors.whiteColor,
              onSurface: AppColors.blackColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      // Then select time
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: startTime ?? TimeOfDay.now(),
        helpText: localizations.selectStartTime,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              dialogBackgroundColor: AppColors.whiteColor,
              colorScheme: const ColorScheme.light(
                primary: AppColors.primaryColor,
                onPrimary: AppColors.whiteColor,
                surface: AppColors.whiteColor,
                onSurface: AppColors.blackColor,
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        onDateRangeChanged(pickedDate, endDate, pickedTime, endTime);
      }
    }
  }

  Future<void> _selectEndDateTime(BuildContext context) async {
    final localizations = context.localizations;
    
    // Ensure end date is at least the same as start date
    final DateTime minDate = startDate ?? DateTime.now();
    
    // First select date
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: endDate ?? minDate,
      firstDate: minDate,
      lastDate: DateTime.now().add(const Duration(days: 365)),
      helpText: localizations.selectEndDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: AppColors.whiteColor,
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryColor,
              onPrimary: AppColors.whiteColor,
              surface: AppColors.whiteColor,
              onSurface: AppColors.blackColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      // Then select time
      TimeOfDay initialTime = endTime ?? TimeOfDay.now();
      
      // If it's the same day as start date, ensure end time is after start time
      if (startDate != null && startTime != null && 
          pickedDate.year == startDate!.year && 
          pickedDate.month == startDate!.month && 
          pickedDate.day == startDate!.day) {
        
        final startMinutes = startTime!.hour * 60 + startTime!.minute;
        final initialMinutes = initialTime.hour * 60 + initialTime.minute;
        
        if (initialMinutes <= startMinutes) {
          // Add 1 hour to start time as minimum end time
          final newMinutes = startMinutes + 60;
          initialTime = TimeOfDay(
            hour: (newMinutes ~/ 60) % 24,
            minute: newMinutes % 60,
          );
        }
      }
      
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
        helpText: localizations.selectEndTime,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              dialogBackgroundColor: AppColors.whiteColor,
              colorScheme: const ColorScheme.light(
                primary: AppColors.primaryColor,
                onPrimary: AppColors.whiteColor,
                surface: AppColors.whiteColor,
                onSurface: AppColors.blackColor,
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        // Validate that end time is after start time if same day
        if (startDate != null && startTime != null && 
            pickedDate.year == startDate!.year && 
            pickedDate.month == startDate!.month && 
            pickedDate.day == startDate!.day) {
          
          final startMinutes = startTime!.hour * 60 + startTime!.minute;
          final endMinutes = pickedTime.hour * 60 + pickedTime.minute;
          
          if (endMinutes <= startMinutes) {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('End time must be after start time'),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }
        }
        
        onDateRangeChanged(startDate, pickedDate, startTime, pickedTime);
      }
    }
  }
}