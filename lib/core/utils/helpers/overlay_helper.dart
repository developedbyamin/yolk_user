import 'package:flutter/material.dart';

class OverlayHelper {
  OverlayHelper._();

  static void showOverlay({
    required BuildContext context,
    required String message,
    Color backgroundColor = Colors.green,
    IconData icon = Icons.check_circle,
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            top: 50.0,
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))],
                ),
                child: Row(
                  children: [
                    Icon(icon, color: Colors.white),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        message,
                        style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  static void showSuccess(BuildContext context, String message) {
    showOverlay(context: context, message: message, backgroundColor: Colors.green, icon: Icons.check_circle);
  }

  static void showWarning(BuildContext context, String message) {
    showOverlay(context: context, message: message, backgroundColor: Colors.orange, icon: Icons.warning);
  }

  static void showError(BuildContext context, String message) {
    showOverlay(context: context, message: message, backgroundColor: Colors.red, icon: Icons.error);
  }
}
