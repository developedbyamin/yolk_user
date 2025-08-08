import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:yolla/core/extensions/localization_extension.dart';
import 'package:yolla/src/presentation/qr/viewmodel/qr_cubit.dart';
import 'package:yolla/src/presentation/qr/viewmodel/qr_state.dart';
import 'package:yolla/src/presentation/qr/views/widgets/product_list_bottom_sheet.dart';
import 'package:yolla/src/data/models/product/product_model.dart';

class QrView extends StatefulWidget {
  const QrView({super.key});

  @override
  State<QrView> createState() => _QrViewState();
}

class _QrViewState extends State<QrView> {
  bool _isBottomSheetOpen = false;
  MobileScannerController? _scannerController;

  @override
  void initState() {
    super.initState();
    _scannerController = MobileScannerController();
    // Reset QR cubit state when entering the view
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QrCubit>().resetScanning();
    });
  }

  @override
  void dispose() {
    _scannerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    
    return BlocListener<QrCubit, QrState>(
      listener: (context, state) {
        if (state is QrProductsLoaded && state.isBottomSheetVisible && !_isBottomSheetOpen) {
          setState(() {
            _isBottomSheetOpen = true;
          });
          // Stop the scanner when bottom sheet opens
          _scannerController?.stop();
          _showProductBottomSheet(context, state.products);
        } else if (state is QrInitial && _isBottomSheetOpen) {
          // All products removed, close bottom sheet
          setState(() {
            _isBottomSheetOpen = false;
          });
          // Restart scanner when bottom sheet closes
          _scannerController?.start();
          Navigator.pop(context);
        } else if (state is QrError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: BlocBuilder<QrCubit, QrState>(
        builder: (context, state) {
          final isScanningEnabled = !_isBottomSheetOpen;
        
          return Scaffold(
          extendBody: false,
          body: Stack(
            children: [
              // Mobile Scanner - Supports both QR codes and barcodes
              MobileScanner(
                controller: _scannerController,
                onDetect: (BarcodeCapture capture) {
                  // Only process scans when scanning is enabled
                  if (!isScanningEnabled) return;
                  
                  final List<Barcode> barcodes = capture.barcodes;
                  if (barcodes.isNotEmpty) {
                    final barcode = barcodes.first;
                    final scannedText = barcode.rawValue;
                    if (scannedText != null && scannedText.isNotEmpty) {
                      context.read<QrCubit>().onBarcodeScanned(scannedText);
                    }
                  }
                },
                fit: BoxFit.cover,
              ),

          // Scanning frame overlay
          Center(
            child: Container(
              width: 250,
              height: 250,
              child: Stack(
                children: [
                  // Corner decorations
                  ...List.generate(4, (index) {
                    return Positioned(
                      top: index < 2 ? 0 : null,
                      bottom: index >= 2 ? 0 : null,
                      left: index % 2 == 0 ? 0 : null,
                      right: index % 2 == 1 ? 0 : null,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border(
                            top: index < 2
                                ? BorderSide(color: Colors.green, width: 4)
                                : BorderSide.none,
                            bottom: index >= 2
                                ? BorderSide(color: Colors.green, width: 4)
                                : BorderSide.none,
                            left: index % 2 == 0
                                ? BorderSide(color: Colors.green, width: 4)
                                : BorderSide.none,
                            right: index % 2 == 1
                                ? BorderSide(color: Colors.green, width: 4)
                                : BorderSide.none,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: index == 0 ? const Radius.circular(12) : Radius.zero,
                            topRight: index == 1 ? const Radius.circular(12) : Radius.zero,
                            bottomLeft: index == 2 ? const Radius.circular(12) : Radius.zero,
                            bottomRight: index == 3 ? const Radius.circular(12) : Radius.zero,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),

          // Instructions
          Positioned(
            bottom: 150,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                isScanningEnabled 
                    ? localizations.scanInstruction
                    : localizations.scanningDisabled,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isScanningEnabled ? Colors.white : Colors.orange,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          // Scanner icon in center
          Center(
            child: Icon(
              Icons.qr_code_scanner,
              size: 60,
              color: Colors.white.withOpacity(0.3),
            ),
          ),
        ],
      ),
          );
        },
      ),
    );
  }

  void _showProductBottomSheet(BuildContext context, List<ProductModel> products) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.35,
        maxChildSize: 1,
        builder: (context, scrollController) => ProductListBottomSheet(
          products: products,
          scrollController: scrollController,
        ),
      ),
    ).then((_) {
      // Re-enable scanning when bottom sheet is closed
      setState(() {
        _isBottomSheetOpen = false;
      });
      // Restart scanner when bottom sheet closes
      _scannerController?.start();
      context.read<QrCubit>().hideBottomSheet();
    });
  }
}