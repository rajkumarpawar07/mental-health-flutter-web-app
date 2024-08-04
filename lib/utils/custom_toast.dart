import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class CustomToast {
  static void infoToast(
      BuildContext context, String title, String description) {
    toastification.show(
      context: context,
      autoCloseDuration: const Duration(seconds: 3),
      title: Text(title),
      description: Text(description),
      animationDuration: const Duration(milliseconds: 300),
      icon: const Icon(Icons.check),
      backgroundColor: const Color(0xff1976d2),
      foregroundColor: Colors.white,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(8),
      showProgressBar: true,
      closeOnClick: false,
      pauseOnHover: true,
    );
  }
}
