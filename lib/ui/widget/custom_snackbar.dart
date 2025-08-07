import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked_services/stacked_services.dart'; // Import stacked package

class AppSnackBar {
  static void showSuccess(String message) {
    _showSnackBar(
      message,
      backgroundColor: Colors.grey,
      icon: const Icon(Icons.abc, color: Colors.white),
      // icon: Image.asset(
      //   AppImages.app,
      //   height: 24.h,
      //   width: 24.w,
      // ),
    );
  }

  static void showError(String message) {
    _showSnackBar(
      message,
      backgroundColor: Colors.redAccent,
      icon: const Icon(Icons.abc, color: Colors.white),
    );
  }

  static void showInfo(String message) {
    _showSnackBar(
      message,
      backgroundColor: Colors.grey,
      icon: const Icon(Icons.abc, color: Colors.white),
    );
  }

  static void showWarning(String message) {
    _showSnackBar(
      message,
      backgroundColor: Colors.orange,
      icon: const Icon(Icons.warning, color: Colors.white),
    );
  }

  static void _showSnackBar(
    String message, {
    required Color backgroundColor,
    required Widget icon,
    int duration = 4000,
  }) {
    final context = StackedService.navigatorKey?.currentContext;
    if (context == null) {
      assert(false,
          'Context is null. Make sure StackedService is properly initialized.');
      return;
    }

    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: Duration(milliseconds: duration),
      margin: EdgeInsets.only(
        bottom: keyboardHeight > 0 ? keyboardHeight + 20 : 20,
        left: 16,
        right: 16,
      ),
      content: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 20),
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ],
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}