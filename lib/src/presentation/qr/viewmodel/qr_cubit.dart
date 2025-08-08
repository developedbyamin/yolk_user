import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yolla/src/data/models/product/product_model.dart';
import 'package:yolla/src/presentation/qr/viewmodel/qr_state.dart';

class QrCubit extends Cubit<QrState> {
  QrCubit() : super(QrInitial()) {
    _loadProducts();
  }

  List<ProductModel> _allProducts = [];

  Future<void> _loadProducts() async {
    try {
      final String jsonString = await rootBundle.loadString('lib/src/data/mock_products.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      
      _allProducts = jsonList.map((json) {
        final productName = json['name'].toString().toLowerCase();
        final description = json['description'].toString().toLowerCase();
        final weight = json['weight'] as num?;
        
        // Determine unit and step based on product type
        String unit = 'pcs';
        double step = 1.0;
        
        if (_isWeightBasedProduct(productName, description, weight)) {
          unit = 'kg';
          step = 0.1;
        }
        // All other products use 'pcs' with step 1.0
        
        return ProductModel(
          id: json['id'],
          name: json['name'],
          barcode: json['code'],
          price: (json['price'] as num).toDouble(),
          description: json['description'],
          quantity: 0.0,
          unit: unit,
          step: step,
        );
      }).toList();
    } catch (e) {
      print('Error loading products: $e');
      // Fallback to empty list if loading fails
      _allProducts = [];
    }
  }

  // Helper method to determine if product should be measured by weight (kg)
  // Only vegetables, eggs, and meats use kg
  bool _isWeightBasedProduct(String name, String description, num? weight) {
    final weightBasedKeywords = [
      // Vegetables
      'kartof', 'turp', 'soğan', 'tərəvəz', 'vegetable',
      
      // Eggs
      'yumurta', 'egg',
      
      // Meats and Fish
      'balıq', 'toyuq', 'dana', 'quzu', 'kolbasa', 'sosiska',
      'et', 'ət', 'meat', 'fish', 'filesi', 'qabırğa',
      'tuna'
    ];
    
    return weightBasedKeywords.any((keyword) => 
      name.contains(keyword) || description.contains(keyword)
    ) && (weight != null && weight > 0);
  }

  void onBarcodeScanned(String scannedValue) {
    // Allow repeated scanning for immediate quantity updates
    _processScan(scannedValue);
  }

  void _processScan(String scannedValue) {
    try {
      
      // In real app, you would search by barcode/QR code from API
      final isQRCode = _isQRCode(scannedValue);
      final isBarcodeProduct = _isBarcodeProduct(scannedValue);
      
      if (isQRCode || isBarcodeProduct) {
        // Filter products based on the scanned value
        final product = _getProductByCode(scannedValue);
        
        if (product != null) {
          // Get current state to preserve existing products
          final currentState = state;
          List<ProductModel> currentProducts = [];
          
          if (currentState is QrProductsLoaded) {
            currentProducts = List.from(currentState.products);
          }
          
          // Check if product already exists in the list
          final existingIndex = currentProducts.indexWhere((p) => p.id == product.id);
          
          if (existingIndex >= 0) {
            // Product exists, increase quantity by step
            final existingProduct = currentProducts[existingIndex];
            currentProducts[existingIndex] = existingProduct.copyWith(
              quantity: existingProduct.quantity + existingProduct.step,
            );
          } else {
            // New product, add with appropriate step quantity
            currentProducts.add(product.copyWith(quantity: product.step));
          }
          
          // Immediately emit with bottom sheet visible
          emit(QrProductsLoaded(
            products: currentProducts,
            isBottomSheetVisible: true,
          ));
        } else {
          // For demo purposes, if no exact match found, create a new product
          final currentState = state;
          List<ProductModel> currentProducts = [];
          
          if (currentState is QrProductsLoaded) {
            currentProducts = List.from(currentState.products);
          }
          
          // Create a generic product from the scanned code
          final newProduct = ProductModel(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            name: 'Scanned Product',
            barcode: scannedValue,
            price: 0.0,
            description: 'Product scanned with code: $scannedValue',
            quantity: 1.0,
            unit: 'pcs',
            step: 1.0,
          );
          
          // Check if this barcode was already scanned
          final existingIndex = currentProducts.indexWhere((p) => p.barcode == scannedValue);
          
          if (existingIndex >= 0) {
            // Increase quantity of existing product by step
            final existingProduct = currentProducts[existingIndex];
            currentProducts[existingIndex] = existingProduct.copyWith(
              quantity: existingProduct.quantity + existingProduct.step,
            );
          } else {
            // Add new product
            currentProducts.add(newProduct);
          }
          
          emit(QrProductsLoaded(
            products: currentProducts,
            isBottomSheetVisible: true,
          ));
        }
      } else {
        emit(QrError('Scanned code format not recognized'));
      }
    } catch (e) {
      emit(QrError('Failed to process scan: ${e.toString()}'));
    }
  }

  // Helper method to detect if scanned value is a QR code
  bool _isQRCode(String value) {
    // QR codes are typically longer and may contain URLs or complex data
    return value.length > 20 || 
           value.startsWith('http') || 
           value.contains('://') ||
           value.contains('\n'); // QR codes can contain multiple lines
  }

  // Helper method to detect if scanned value is a product barcode
  bool _isBarcodeProduct(String value) {
    // Product barcodes are typically numeric and have specific lengths
    // UPC-A: 12 digits, EAN-13: 13 digits, etc.
    // Also accept codes with spaces (like "1748 2097")
    final cleanValue = value.replaceAll(' ', '').trim();
    final numericPattern = RegExp(r'^\d+$');
    return numericPattern.hasMatch(cleanValue) && 
           (cleanValue.length >= 8 && cleanValue.length <= 14);
  }

  // Helper method to get a specific product by scanned code
  ProductModel? _getProductByCode(String code) {
    // In real app, this would make an API call to search by barcode/QR code
    // For demo, match against mock product barcodes from JSON file
    try {
      // Clean the scanned code (remove spaces, normalize)
      final cleanCode = code.replaceAll(' ', '').trim();
      
      return _allProducts.firstWhere((product) => 
        product.barcode.replaceAll(' ', '').trim() == cleanCode
      );
    } catch (e) {
      // No product found with matching barcode
      return null;
    }
  }

  void increaseQuantity(String productId) {
    final currentState = state;
    if (currentState is QrProductsLoaded) {
      final updatedProducts = currentState.products.map((product) {
        if (product.id == productId) {
          return product.copyWith(quantity: product.quantity + product.step);
        }
        return product;
      }).toList();

      emit(currentState.copyWith(products: updatedProducts));
    }
  }

  void decreaseQuantity(String productId) {
    final currentState = state;
    if (currentState is QrProductsLoaded) {
      final updatedProducts = <ProductModel>[];
      
      for (final product in currentState.products) {
        if (product.id == productId && product.quantity > 0) {
          final newQuantity = product.quantity - product.step;
          // Only keep products with quantity > 0
          if (newQuantity > 0) {
            updatedProducts.add(product.copyWith(quantity: newQuantity));
          }
          // If quantity becomes 0, we don't add it to the list (effectively removing it)
        } else {
          updatedProducts.add(product);
        }
      }

      // If no products remain, close the bottom sheet
      if (updatedProducts.isEmpty) {
        emit(QrInitial());
      } else {
        emit(currentState.copyWith(products: updatedProducts));
      }
    }
  }

  void deleteProduct(String productId) {
    final currentState = state;
    if (currentState is QrProductsLoaded) {
      final updatedProducts = currentState.products
          .where((product) => product.id != productId)
          .toList();

      // If no products remain, close the bottom sheet
      if (updatedProducts.isEmpty) {
        emit(QrInitial());
      } else {
        emit(currentState.copyWith(products: updatedProducts));
      }
    }
  }

  void hideBottomSheet() {
    final currentState = state;
    if (currentState is QrProductsLoaded) {
      emit(currentState.copyWith(isBottomSheetVisible: false));
    }
  }

  void showBottomSheet() {
    final currentState = state;
    if (currentState is QrProductsLoaded) {
      emit(currentState.copyWith(isBottomSheetVisible: true));
    }
  }

  void resetScanning() {
    emit(QrInitial());
  }
}