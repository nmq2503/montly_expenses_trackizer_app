import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  CustomSnackbar._();

  static void showSuccessSnackbar(String title, String message) {
    if (Get.isSnackbarOpen) return;

    Get.snackbar(
      title,
      message,
      margin: const EdgeInsets.all(12),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  static void showErrorSnackbar(String title, String message) {
    if (Get.isSnackbarOpen) return;

    Get.snackbar(
      title,
      message,
      margin: const EdgeInsets.all(12),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}