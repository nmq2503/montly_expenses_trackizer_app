import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common_widget/custom_snackbar.dart';
import '../../../controllers/app_controller.dart';
import '../../../routes/app_routes.dart';

class SettingsViewController extends GetxController {
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late AppController _appController;
  AppController get appController => _appController;

  @override
  void onInit() {
    super.onInit();
    _appController = Get.find<AppController>();
  }

  void logOut() async {
    bool? shouldLogout = await Get.dialog(
      AlertDialog(
        title: const Text("Xác nhận đăng xuất"),
        backgroundColor: Colors.grey[900],
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        contentTextStyle: const TextStyle(color: Colors.white70),
        content: const Text("Bạn có chắc chắn muốn đăng xuất không?"),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            style: TextButton.styleFrom(foregroundColor: Colors.grey[300]),
            child: const Text("Huỷ"),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
            child: const Text("Đăng xuất"),
          ),
        ],
      ),
    );

    if (shouldLogout == true) {
      try {
        _isLoading.value = true;
        await _appController.clearData();
        await Future.delayed(const Duration(seconds: 2), () {
          Get.offAllNamed(AppRoutes.signIn);
        });
        // _isLoading.value = false;
      } catch (e) {
        CustomSnackbar.showErrorSnackbar("Lỗi", "Không đăng xuất được: $e");
      } finally {
        _isLoading.value = false;
      }
    }
  }

  void updateSetting(String settingName, dynamic value) {
    // Logic to update the setting
  }

  void resetSettings() {
    // Logic to reset settings to default
  }
}
