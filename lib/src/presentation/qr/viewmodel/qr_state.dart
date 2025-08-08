import 'package:equatable/equatable.dart';
import 'package:yolla/src/data/models/product/product_model.dart';

abstract class QrState extends Equatable {
  const QrState();

  @override
  List<Object?> get props => [];
}

class QrInitial extends QrState {}

class QrScanning extends QrState {}

class QrProductsLoaded extends QrState {
  final List<ProductModel> products;
  final bool isBottomSheetVisible;

  const QrProductsLoaded({
    required this.products,
    this.isBottomSheetVisible = false,
  });

  @override
  List<Object?> get props => [products, isBottomSheetVisible];

  QrProductsLoaded copyWith({
    List<ProductModel>? products,
    bool? isBottomSheetVisible,
  }) {
    return QrProductsLoaded(
      products: products ?? this.products,
      isBottomSheetVisible: isBottomSheetVisible ?? this.isBottomSheetVisible,
    );
  }
}

class QrError extends QrState {
  final String message;

  const QrError(this.message);

  @override
  List<Object?> get props => [message];
}