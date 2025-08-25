import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yolla/core/config/constants/app_colors.dart';
import 'package:yolla/core/extensions/localization_extension.dart';
import 'package:yolla/src/data/models/product/product_model.dart';
import 'package:yolla/src/presentation/qr/viewmodel/qr_cubit.dart';
import 'package:yolla/src/presentation/qr/viewmodel/qr_state.dart';
import 'package:yolla/src/presentation/checkout/checkout_view.dart';
import 'package:yolla/src/presentation/history/viewmodel/order_cubit.dart';

class ProductListBottomSheet extends StatelessWidget {
  final List<ProductModel> products;
  final ScrollController? scrollController;
  final VoidCallback? onProductsCleared;

  const ProductListBottomSheet({
    super.key,
    required this.products,
    this.scrollController,
    this.onProductsCleared,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    
    return BlocBuilder<QrCubit, QrState>(
      builder: (context, state) {
        // Get current products from state, fallback to passed products
        List<ProductModel> currentProducts = products;
        if (state is QrProductsLoaded) {
          currentProducts = state.products;
        }

        return Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: ListView(
            controller: scrollController,
            children: [
              // Handle bar
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 8, bottom: 8),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.lightGrayColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              
              // Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text(
                      localizations.selectProducts,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackColor,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        context.read<QrCubit>().hideBottomSheet();
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: const Text(
                          '✕',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.grayColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Products list
              ...currentProducts.asMap().entries.map((entry) {
                final index = entry.key;
                final product = entry.value;
                return Column(
                  children: [
                    if (index > 0) 
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(
                          color: AppColors.lightGrayColor,
                          height: 1,
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ProductListItem(product: product),
                    ),
                  ],
                );
              }).toList(),
              
              // Total Price Section
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                      '\$${_calculateTotalPrice(currentProducts).toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              
              // Action Buttons Column
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // First Row: Add Product and Add to Cart
                    Row(
                      children: [
                        // Add Product Button (Continue Scanning)
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Close bottom sheet and continue scanning
                              context.read<QrCubit>().hideBottomSheet();
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.lightGrayColor,
                              foregroundColor: AppColors.grayColor,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              localizations.addProduct,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.grayColor,
                              ),
                            ),
                          ),
                        ),
                        
                        const SizedBox(width: 12),
                        
                        // Add to Cart Button
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              final selectedProducts = currentProducts.where((p) => p.quantity > 0).toList();
                              
                              if (selectedProducts.isNotEmpty) {
                                // Add to history
                                await context.read<OrderCubit>().addToCart(selectedProducts);
                                
                                // Clear current QR list via callback
                                onProductsCleared?.call();
                                
                                // Close bottom sheet
                                context.pop();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(localizations.pleaseAddProducts),
                                    backgroundColor: Colors.orange,
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              localizations.addToCart,
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
                    
                    const SizedBox(height: 12),
                    
                    // Second Row: Checkout Button (Full Width)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          final selectedProducts = currentProducts.where((p) => p.quantity > 0).toList();
                          if (selectedProducts.isNotEmpty) {
                            // Navigate to checkout screen with selected products
                            context.read<QrCubit>().hideBottomSheet();
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CheckoutView(),
                                settings: RouteSettings(arguments: selectedProducts),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(localizations.pleaseAddProducts),
                                backgroundColor: Colors.orange,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          localizations.checkout,
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
        );
      },
    );
  }

  double _calculateTotalPrice(List<ProductModel> products) {
    return products.fold(0.0, (total, product) {
      return total + (product.price * product.quantity);
    });
  }
}

class ProductListItem extends StatelessWidget {
  final ProductModel product;

  const ProductListItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          const SizedBox(width: 12),
          
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
                const SizedBox(height: 4),
                Text(
                  product.description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.grayColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                      '\$${(product.price * product.quantity).toStringAsFixed(2)} ${localizations.totalAmount}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),
              ],
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Quantity controls
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Decrease button
              GestureDetector(
                onTap: product.quantity > 0
                    ? () => context.read<QrCubit>().decreaseQuantity(product.id)
                    : null,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: product.quantity > 0 
                        ? AppColors.primaryColor 
                        : AppColors.lightGrayColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '−',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: product.quantity > 0 
                          ? AppColors.whiteColor 
                          : AppColors.grayColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              
              // Quantity display
              Container(
                width: 70,
                alignment: Alignment.center,
                child: Text(
                  _formatQuantity(product.quantity, product.unit, localizations),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              
              // Increase button
              GestureDetector(
                onTap: () => context.read<QrCubit>().increaseQuantity(product.id),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    '+',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.whiteColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              
              const SizedBox(width: 8),
              
              // Delete button
              GestureDetector(
                onTap: () => context.read<QrCubit>().deleteProduct(product.id),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.red,
                      width: 1,
                    ),
                  ),
                  child: const Icon(
                    Icons.delete_outline,
                    size: 18,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatQuantity(double quantity, String unit, localizations) {
    String localizedUnit;
    if (unit == 'kg') {
      localizedUnit = localizations.kg;
      // Format weight quantities to 1 decimal place
      return '${quantity.toStringAsFixed(1)} $localizedUnit';
    } else {
      localizedUnit = localizations.pcs;
      // Format piece quantities as whole numbers
      return '${quantity.toInt()} $localizedUnit';
    }
  }
}