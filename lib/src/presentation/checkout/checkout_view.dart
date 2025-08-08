import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:yolla/core/config/constants/app_colors.dart';
import 'package:yolla/core/extensions/localization_extension.dart';
import 'package:yolla/core/router/routes.dart';
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
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

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
                      
                      // Date and Time Selection Row
                      Row(
                        children: [
                          // Date Selection
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _selectDate(context),
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
                                      localizations.selectDate,
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.grayColor),
                                    ),
                                    const SizedBox(height: 8),
                                    _selectedDate != null
                                        ? Text(
                                            '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.blackColor,
                                            ),
                                          )
                                        : const Icon(
                                            Icons.calendar_today,
                                            color: AppColors.grayColor,
                                            size: 24,
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          
                          const SizedBox(width: 12),
                          
                          // Time Selection
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _selectTime(context),
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
                                      localizations.selectTime,
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.grayColor),
                                    ),
                                    const SizedBox(height: 8),
                                    _selectedTime != null
                                        ? Text(
                                            '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}',
                                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.blackColor,
                                            ),
                                          )
                                        : const Icon(
                                            Icons.access_time,
                                            color: AppColors.grayColor,
                                            size: 24,
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
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
                              deliveryDate: _selectedDate != null 
                                  ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                                  : null,
                              deliveryTime: _selectedTime != null 
                                  ? '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}'
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
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
            textTheme: Theme.of(context).textTheme.copyWith(
              headlineMedium: const TextStyle(color: AppColors.blackColor),
              bodyMedium: const TextStyle(color: AppColors.blackColor),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
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
            textTheme: Theme.of(context).textTheme.copyWith(
              headlineMedium: const TextStyle(color: AppColors.blackColor),
              bodyMedium: const TextStyle(color: AppColors.blackColor),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _showOrderConfirmationDialog(BuildContext context, List<ProductModel> products) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final localizations = context.localizations;
        return AlertDialog(
          title: Text(
            localizations.orderConfirmation,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.blackColor,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localizations.orderConfirmationText(products.length.toString()),
                style: const TextStyle(color: AppColors.blackColor),
              ),
              const SizedBox(height: 8),
              Text(
                '${localizations.total} \$${_calculateTotalPrice(products).toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                localizations.cancel,
                style: const TextStyle(color: AppColors.grayColor),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Go back to QR scanner
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(localizations.orderPlacedSuccessfully),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
              ),
              child: Text(
                localizations.confirmOrder,
                style: const TextStyle(color: AppColors.whiteColor),
              ),
            ),
          ],
        );
      },
    );
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