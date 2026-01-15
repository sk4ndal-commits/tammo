import 'package:flutter/material.dart';

class ToastUtils {
  static void showSuccess(BuildContext context, String message) {
    _showToast(context, message, Colors.green.shade700, Icons.check_circle_outline);
  }

  static void showSuccessToast(BuildContext context, String message) {
    showSuccess(context, message);
  }

  static void showError(BuildContext context, String message) {
    _showToast(context, message, Colors.red.shade700, Icons.error_outline);
  }

  static void _showToast(BuildContext context, String message, Color bgColor, IconData icon) {
    final messenger = ScaffoldMessenger.of(context);
    
    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        backgroundColor: bgColor,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}
