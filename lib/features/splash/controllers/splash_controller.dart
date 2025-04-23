// lib/modules/splash/controllers/splash_controller.dart
import 'package:get/get.dart';

class SplashController extends GetxController {
  final opacity = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 100), () {
      opacity.value = 1.0;
    });
  }

  void goToLogin() {
    Get.toNamed('/login');
  }

  void goToRegister() {
    Get.toNamed('/register');
  }
}
