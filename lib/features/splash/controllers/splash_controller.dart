import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class SplashController extends GetxController {
  final opacity = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 100), () {
      opacity.value = 1.0;
    });
  }

  void autoSignin() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await user.reload(); // đảm bảo thông tin mới nhất
      final refreshedUser = FirebaseAuth.instance.currentUser;

      if (refreshedUser != null) {
        // Nếu vẫn còn phiên đăng nhập
        Get.offAllNamed(AppRoutes.mainTab); // chuyển tới Home
        return;
      }
    }

    // Nếu không còn phiên hoặc chưa đăng nhập
    Get.offAllNamed(AppRoutes.signIn);
  }
}
